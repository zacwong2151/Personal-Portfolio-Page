output "api_gateway_default_invoke_url" {
  description = "The default invoke URL for the API Gateway HTTP API. However, its use is discontinued to support a custom domain name for the API"
  value       = aws_apigatewayv2_api.http_api.api_endpoint
}

output "increment_visitor_count_endpoint" {
  description = "The full URL for the increment visitor count API endpoint"
  value       = "https://${aws_apigatewayv2_domain_name.api_domain_name.domain_name}/visitor-count"
}

output "API_GW_domain_name" {
  description = "Target domain name of the API Gateway"
  value       = aws_apigatewayv2_domain_name.api_domain_name.domain_name_configuration[0].target_domain_name
}

output "API_GW_zone_id" {
  description = "Route 53 Hosted Zone ID of the endpoint."
  value       = aws_apigatewayv2_domain_name.api_domain_name.domain_name_configuration[0].hosted_zone_id
}