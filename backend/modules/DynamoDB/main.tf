resource "aws_dynamodb_table" "visitor_count_table" {
  name = var.dynamodb_table_name

  /*
    The attribute block tells DynamoDB which attributes will form your table's and Global Secondary Index's (if applicable)
     partition and sort key
  */
  attribute {
    name = "Count"
    type = "S" # Data type for the partition key. Could be 'S' for string, 'N' for number, or 'B' for binary
  }

  hash_key = "Count"

  # Billing mode for the table.
  # "PROVISIONED" allows you to specify read and write capacity units,
  # which is essential for staying within the AWS Free Tier for low usage.
  # "PAY_PER_REQUEST" (On-Demand) is simpler but can be more expensive for very low or unpredictable traffic.
  billing_mode = "PROVISIONED"

  # Setting this to 1 RCU is the minimum and helps stay within the free tier. 1 RCU provides 1 strongly consistent read per second 
  read_capacity = 1

  # Setting this to 1 WCU is the minimum and helps stay within the free tier. 1 WCU provides 1 strongly consistent write per second 
  write_capacity = 1

  # Optional: Stream configuration if you need to capture item-level changes.
  # Not strictly necessary for a simple counter, but good to know about.
  # stream_view_type = "NEW_AND_OLD_IMAGES"
  # stream_enabled   = true
}

