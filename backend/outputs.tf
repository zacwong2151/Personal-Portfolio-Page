output "dynamodb_table_arn" {
  description = "The ARN of the DynamoDB VisitorCount table."
  value       = module.DynamoDB.dynamodb_table_arn
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda function."
  value       = module.Lambda.lambda_function_arn
}