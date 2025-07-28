output "api_gateway_invoke_url" {
  description = "The invoke URL for the API Gateway HTTP API, of the form https://{api-id}.execute-api.{region}.amazonaws.com."
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

output "increment_visitor_count_endpoint" {
  description = "The full endpoint URL to call for incrementing visitor count."
  value       = "${aws_apigatewayv2_api.http_api.api_endpoint}/visitor-count"
}