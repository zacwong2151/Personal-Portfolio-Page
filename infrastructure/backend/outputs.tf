output "visitor_count_table_arn" {
  description = "The ARN of the VisitorCount table."
  value       = module.DynamoDB.visitor_count_table_arn
}

output "unique_visitors_table_arn" {
  description = "The ARN of the UniqueVisitors table."
  value       = module.DynamoDB.unique_visitors_table_arn
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = module.Lambda.lambda_function_arn
}

output "increment_visitor_count_endpoint" {
  description = "The full endpoint URL to call for incrementing visitor count."
  value       = module.API-Gateway.increment_visitor_count_endpoint
}