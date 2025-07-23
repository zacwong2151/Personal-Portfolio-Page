# Configure the AWS Provider
provider "aws" {
  profile = "admin-zac-development"
  region  = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
}

module "S3_static_website_bucket" {
  source = "./modules/S3-bucket"

  bucket_name = var.bucket_name
}

module "ACM" {
  source = "./modules/ACM"

  website_domain_name = var.website_domain_name
}

module "CloudFront" {
  source = "./modules/CloudFront"

  website_domain_name = var.website_domain_name
  bucket_name         = var.bucket_name

  S3_website_endpoint = module.S3_static_website_bucket.S3_website_endpoint
  acm_cert_arn        = module.ACM.acm_cert_arn
}

module "Route53" {
  source = "./modules/Route53"

  website_domain_name = var.website_domain_name

  cloudfront_domain_name    = module.CloudFront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.CloudFront.cloudfront_hosted_zone_id
}
