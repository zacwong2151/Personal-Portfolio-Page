variable "bucket_name" {
  description = "The name for the S3 bucket for static website hosting."
  type        = string
  default     = "loonymoony.click"
}

variable "hosted_zone_id_us-east-1" {
    description = "This is the specific Hosted Zone ID for S3 static website endpoints in the us-east-1 region. This value is fixed by AWS"
    type        = string
    default     = "Z3AQBSTGFYJSTF"
}