# 1. Create the API Gateway HTTP API
resource "aws_apigatewayv2_api" "http_api" {
  name          = "IncrementVisitorCountApi" # Name of the API
  protocol_type = "HTTP"

  # Enable CORS for your frontend to call this API
  cors_configuration {
    allow_headers     = ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key", "X-Amz-Security-Token"]
    allow_methods     = ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    allow_origins     = ["https://${var.website_domain_name}", "http://localhost:5173/"]
    allow_credentials = false # Whether credentials are included in the CORS request (e.g., cookies, auth headers)
    max_age           = 300   # Number of seconds that the browser should cache preflight request results
  }
}

# 2. Create the Lambda Integration
# This connects the API Gateway route to your Lambda function.
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id                 = aws_apigatewayv2_api.http_api.id
  integration_type       = "AWS_PROXY"             # For Lambda, AWS_PROXY is the standard integration type
  integration_method     = "POST"                  # API Gateway invokes Lambda using POST, regardless of the HTTP method on the route.
  integration_uri        = var.lambda_function_arn # The ARN of the Lambda function
  passthrough_behavior   = "WHEN_NO_MATCH"         # Recommended for AWS_PROXY
  payload_format_version = "2.0"                   # Use 2.0 for HTTP APIs for simpler payload structure
  timeout_milliseconds   = 30000                   # Max 30 seconds for HTTP APIs
}

# 3. Define the Route: POST /visitor-count
resource "aws_apigatewayv2_route" "increment_visitor_count_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /visitor-count" # Define the HTTP method and path
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# 4. Create a default stage for the API
# HTTP APIs automatically deploy changes to a default stage.
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "$default" # The default stage for HTTP APIs
  auto_deploy = true       # Whether updates to an API automatically trigger a new deployment
}

# 5. Manages an AWS Lambda permission. 
# Use this resource to grant external sources (e.g., EventBridge Rules, SNS, or S3) permission to invoke Lambda functions
resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn    # ARN of the Lambda function
  principal     = "apigateway.amazonaws.com" # AWS service or account that invokes the function

  # The "source_arn" ensures that only this specific API Gateway can invoke the Lambda.
  source_arn = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
  # The format for HTTP API source_arn is:
  # arn:aws:execute-api:REGION:ACCOUNT_ID:API_ID/*/*
  # The /*/* at the end means any stage and any method/path.
  # If you wanted to restrict to a specific route/method, it would be:
  # arn:aws:execute-api:REGION:ACCOUNT_ID:API_ID/STAGE_NAME/METHOD/PATH
}
