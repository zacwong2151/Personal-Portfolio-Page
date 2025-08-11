variable "lambda_function_arn" {
  description = "The ARN of your Lambda function"
  type        = string
}

variable "website_domain_name" {
  description = "Your website's domain name for CORS."
  type        = string
}