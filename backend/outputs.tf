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

output "api_gateway_invoke_url" {
  description = "The invoke URL for the API Gateway HTTP API, of the form https://{api-id}.execute-api.{region}.amazonaws.com."
  value       = module.API-Gateway.api_gateway_invoke_url
}