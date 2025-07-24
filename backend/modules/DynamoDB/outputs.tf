output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB VisitorCount table."
  value       = aws_dynamodb_table.visitor_count_table.arn
}
