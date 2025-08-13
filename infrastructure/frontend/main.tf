# Configure the AWS Provider
provider "aws" {
  #   profile = "admin-zac-development" # Removed so that this AWS provider block is agnostic to the credential source (which could be your local CLI, or the Github Actions runner)
  region = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
}

# Generates a random string to use as a secret header value for S3 origin access
resource "random_string" "origin_access_header_value" {
  length  = 32
  special = false
  upper   = true
  lower   = true
  numeric = true
}

module "S3_buckets" {
  source = "./modules/S3-bucket"

  website_bucket_name         = var.website_bucket_name
  terraform_state_bucket_name = var.terraform_state_bucket_name
  web_files_path              = var.web_files_path
  cloudfront_arn              = module.CloudFront.cloudfront_arn
  cloudfront_custom_header    = random_string.origin_access_header_value.result
}

module "ACM" {
  source = "./modules/ACM"

  website_domain_name = var.website_domain_name
}

module "CloudFront" {
  source = "./modules/CloudFront"

  website_domain_name = var.website_domain_name
  bucket_name         = var.website_bucket_name

  S3_website_endpoint      = module.S3_buckets.S3_website_endpoint
  acm_cert_arn             = module.ACM.acm_cert_arn
  cloudfront_custom_header = random_string.origin_access_header_value.result
}

module "Route53" {
  source = "./modules/Route53"

  website_domain_name = var.website_domain_name

  cloudfront_domain_name    = module.CloudFront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.CloudFront.cloudfront_hosted_zone_id
}
