output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB VisitorCount table."
  value       = module.DynamoDB.dynamodb_table_arn
}
