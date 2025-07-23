variable "bucket_name" {
  description = "The name of the S3 bucket configured for static website hosting."
  type        = string
}

variable "website_domain_name" {
  description = "The custom domain name for your website (loonymoony.click)."
  type        = string
}

variable "S3_website_endpoint" {
  type = string
}

variable "acm_cert_arn" {
  description = "The ARN of the validated ACM certificate for your custom domain."
  type        = string
}