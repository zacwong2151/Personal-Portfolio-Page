output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB VisitorCount table."
  value       = module.DynamoDB.dynamodb_table_arn
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = module.Lambda.lambda_function_arn
}

output "api_gateway_invoke_url" {
  description = "The invoke URL for the API Gateway HTTP API, of the form https://{api-id}.execute-api.{region}.amazonaws.com."
  value       = module.API-Gateway.api_gateway_invoke_url
}