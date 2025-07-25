import { DynamoDBClient } from "@aws-sdk/client-dynamodb"
import { DynamoDBDocumentClient, UpdateCommand  } from "@aws-sdk/lib-dynamodb"

const client = new DynamoDBClient({
  region: "us-east-1",
});

const docClient = DynamoDBDocumentClient.from(client);

export const handler = async (event, context) => {
  const params = {
    TableName: "VisitorCount",
    Key: {
      ["id"]: "visitor_count",
    },
    
    UpdateExpression: "SET #countAttr = if_not_exists(#countAttr, :start) + :inc",
    
    ExpressionAttributeNames: {
      "#countAttr": "count", // Alias: '#countAttr' maps to the actual 'count' attribute.
    },
    
    // Define the values used in the UpdateExpression
    ExpressionAttributeValues: {
      ":inc": 1, 
      ":start": 0,
    },
    
    // ReturnValues:
    // Specifies what data to return after the update.
    // UPDATED_NEW returns only the attributes that were modified, after the modification.
    ReturnValues: "UPDATED_NEW", 
  };

  try {
    const data = await docClient.send(new UpdateCommand(params));
    const newCount = data.Attributes.count;
    console.log(`Successfully updated visitor count. New count: ${newCount}`);
    
    // Return a successful response for API Gateway
    return {
      statusCode: 200,
      headers: {
        "Content-Type": "application/json",
        // Add CORS headers if your frontend is hosted on a different domain than API Gateway
        // (e.g., S3/CloudFront domain vs. API Gateway invoke URL)
        "Access-Control-Allow-Origin": "*", // IMPORTANT: Restrict this to your actual website domain in production!
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token",
      },
      body: JSON.stringify({ message: "Visitor count incremented", newCount: newCount }),
    };

  } catch (error) {
    console.error("Error incrementing visitor count:", error);
    
    // Return an error response for API Gateway
    return {
      statusCode: 500,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*", // IMPORTANT: Restrict this to your actual website domain in production!
        "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
        "Access-Control-Allow-Headers": "Content-Type, X-Amz-Date, Authorization, X-Api-Key, X-Amz-Security-Token",
      },
      body: JSON.stringify({ message: "Failed to update visitor count", error: error.message }),
    };
  }
}
