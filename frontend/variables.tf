variable "bucket_name" {
  description = "The name for the S3 bucket for static website hosting"
  type        = string
  default     = "loonymoony.click"
}

variable "website_domain_name" {
  description = "The website address"
  type        = string
  default     = "loonymoony.click"
}
