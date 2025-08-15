import { DynamoDBClient } from "@aws-sdk/client-dynamodb"
import { DynamoDBDocumentClient, UpdateCommand, GetCommand, PutCommand } from "@aws-sdk/lib-dynamodb"
import { convertTimestampToReadableDateTime } from "./util.js"

const client = new DynamoDBClient({
    region: "us-east-1",
});

const docClient = DynamoDBDocumentClient.from(client);

const VISITOR_COUNT_TABLE_NAME = "VisitorCount";
const UNIQUE_VISITORS_TABLE_NAME = "UniqueVisitors";
const VISITOR_COUNT_ITEM_ID = "visitor_count"; // Partition key value for the single counter row
const UNIQUE_VISIT_WINDOW_HOURS = 24; // How long an IP is considered "unique" (e.g., 24 hours)

export const handler = async (event, context) => {
    let clientIp = "UNKNOWN"; // Default if IP cannot be determined

    // Extract client IP from API Gateway event
    // For HTTP API, the IP is usually in event.requestContext.http.sourceIp
    if (event?.requestContext?.http?.sourceIp) {
        clientIp = event.requestContext.http.sourceIp;
    }

    console.log(`Received request from IP: ${clientIp}`);

    const currentTimeMs = Date.now() // in milliseconds
    const ttlExpirationTimeSeconds = Math.floor((currentTimeMs + UNIQUE_VISIT_WINDOW_HOURS * 60 * 60 * 1000) / 1000) // in seconds

    const getVisitorCount = async () => {
        const getVisitorCountParams = {
            TableName: VISITOR_COUNT_TABLE_NAME,
            Key: {
                "id": VISITOR_COUNT_ITEM_ID,
            }
        }

        const visitorCountData = await docClient.send(new GetCommand(getVisitorCountParams))
        const visitorCount = visitorCountData.Item ? visitorCountData.Item.count : 0;
        console.log(`No change to visitor count. Count is ${visitorCount}`)

        return visitorCount
    }

    const incrementVisitorCount = async () => {
        const incrementVisitorCountParams = {
            TableName: VISITOR_COUNT_TABLE_NAME,
            Key: {
                id: VISITOR_COUNT_ITEM_ID,
            },
            UpdateExpression: "SET #countAttr = if_not_exists(#countAttr, :start) + :inc",
            ExpressionAttributeNames: {
                "#countAttr": "count",
            },
            ExpressionAttributeValues: {
                ":inc": 1,
                ":start": 0,
            },
            ReturnValues: "UPDATED_NEW",
        }

        const updateVisitorCountResult = await docClient.send(new UpdateCommand(incrementVisitorCountParams))
        const newCount = updateVisitorCountResult.Attributes.count
        console.log(`Visitor count incremented. New count: ${updateVisitorCountResult.Attributes.count}`)

        return newCount
    }

    const updateTimestampOfVisitor = async () => {
        const updateTimestampParams = {
            TableName: UNIQUE_VISITORS_TABLE_NAME,
            Key: {
                ipAddress: clientIp,
            },
            UpdateExpression: "SET #ts = :newTimestamp, #ttl = :newTTL, #tsDateTime = :newTimestampDateTime, #ttlDateTime = :newTTLDateTime, #noOfVisits = #noOfVisits + :inc",
            ExpressionAttributeNames: {
                "#ts": "timestampMs",
                "#ttl": "ttl",
                "#tsDateTime": "timestampDateTime",
                "#ttlDateTime": "ttlDateTime",
                "#noOfVisits": "noOfVisits",
            },
            ExpressionAttributeValues: {
                ":newTimestamp": currentTimeMs,
                ":newTTL": ttlExpirationTimeSeconds,
                ":newTimestampDateTime": convertTimestampToReadableDateTime(currentTimeMs),
                ":newTTLDateTime": convertTimestampToReadableDateTime(ttlExpirationTimeSeconds * 1000),
                ":inc": 1
            },
            ReturnValues: "UPDATED_NEW"
        };
        await docClient.send(new UpdateCommand(updateTimestampParams))
        console.log(`Updated time stamp and TTL for client IP ${clientIp}`)
    }

    const insertUniqueVisitor = async () => {
        const insertUniqueVisitorParams = {
            TableName: UNIQUE_VISITORS_TABLE_NAME,
            Item: {
                ipAddress: clientIp,
                noOfVisits: 1,
                timestampMs: currentTimeMs, // in milliseconds since epoch 
                timestampDateTime: convertTimestampToReadableDateTime(currentTimeMs),
                ttl: ttlExpirationTimeSeconds, // in seconds since epoch
                ttlDateTime: convertTimestampToReadableDateTime(ttlExpirationTimeSeconds * 1000)
            }
        }
        await docClient.send(new PutCommand(insertUniqueVisitorParams))
        console.log(`Client IP ${clientIp} logged in UniqueVisitors`)
    }

    try {
        const getIpParams = {
            TableName: UNIQUE_VISITORS_TABLE_NAME,
            Key: {
                ipAddress: clientIp,
            },
            ConsistentRead: true // ensures that you always read the most up-to-date data for the IP, preventing race conditions
        }

        const ipData = await docClient.send(new GetCommand(getIpParams))

        const isNewVisitor = ipData.Item ? false : true
        const lastVisitTimestamp = ipData.Item ? ipData.Item.timestamp : 0

        let visitorCount = 0

        if (isNewVisitor) {
            // scenario 1: record is not present in UniqueVisitors table. Insert entry in UniqueVisitors table and update entry in VisitorCount table
            await insertUniqueVisitor()
            visitorCount = await incrementVisitorCount()
        } else if (currentTimeMs - lastVisitTimestamp > UNIQUE_VISIT_WINDOW_HOURS * 60 * 60 * 1000) {
            /* 
                scenario 2: record is present in UniqueVisitors table, but record has already expired (but not removed by TTL).
                Update entry in UniqueVisitors, and update entry in VisitorCount
            */
            await updateTimestampOfVisitor()
            visitorCount = await incrementVisitorCount()
        } else {
            // scenario 3: record is present in UniqueVisitors table, and has not expired. Update entry in UniqueVisitors.
            await updateTimestampOfVisitor()
            visitorCount = await getVisitorCount()
        }

        return {
            statusCode: 200,
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                message: isNewVisitor ? "Unique visitor count incremented" : "Visitor count fetched (not incremented)",
                clientIp: clientIp,
                visitorCount: visitorCount
            }),
        };

    } catch (error) {
        console.error("Error processing client TTL or visitor count:", error);

        return {
            statusCode: 500,
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({ 
                message: "Failed to process client TTL or visitor count", 
                error: error.message
            }),
        };
    }
};