variable "bucket_name" {
  description = "The name for the S3 bucket for static website hosting."
  type        = string
}

variable "cloudfront_arn" {
  description = "CloudFront distribution's ARN"
  type        = string
}

variable "cloudfront_custom_header" {
  description = "Custom header value that received from a CloudFront request"
  type        = string
}