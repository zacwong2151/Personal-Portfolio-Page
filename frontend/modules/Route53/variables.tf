variable "website_domain_name" {
  description = "Domain name of the website"
  type        = string
}

variable "hosted_zone_id_us-east-1" {
  description = "This is the specific Hosted Zone ID for S3 static website endpoints in the us-east-1 region. This value is fixed by AWS"
  type        = string
  default     = "Z3AQBSTGFYJSTF"
}

variable "cloudfront_domain_name" {
  description = "The default domain name given to a CloudFront distribution"
  type        = string
}

variable "cloudfront_hosted_zone_id" {
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2"
  type        = string
}