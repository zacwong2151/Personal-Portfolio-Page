variable "S3_website_domain_name" {
  description = "Domain of the S3 website endpoint. This is used to create Route 53 alias records."
  type        = string
}

variable "website_domain_name" {
    description = "Domain name of the website"
    type        = string
}

variable "hosted_zone_id_us-east-1" {
    description = "This is the specific Hosted Zone ID for S3 static website endpoints in the us-east-1 region. This value is fixed by AWS"
    type        = string
    default     = "Z3AQBSTGFYJSTF"
}