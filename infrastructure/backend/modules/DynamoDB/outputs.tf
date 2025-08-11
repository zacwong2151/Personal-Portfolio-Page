output "visitor_count_table_arn" {
  description = "The ARN of the VisitorCount table."
  value       = aws_dynamodb_table.visitor_count_table.arn
}

output "unique_visitors_table_arn" {
  description = "The ARN of the UniqueVisitors table."
  value       = aws_dynamodb_table.unique_visitors_table.arn
}
