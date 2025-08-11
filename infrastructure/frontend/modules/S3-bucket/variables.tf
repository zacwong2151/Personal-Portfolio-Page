variable "website_bucket_name" {
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

variable "web_files_path" {
  description = "The absolute or relative path to the directory containing the web files to upload."
  type        = string
}

variable "terraform_state_bucket_name" {
  description = "The name of the bucket used to store the terraform state file"
  type        = string
}