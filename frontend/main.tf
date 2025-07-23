# Configure the AWS Provider
provider "aws" {
  profile = "admin-zac-development"
  region  = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
}

module "S3_static_website_bucket" {
    source = "./modules/S3-bucket"

    bucket_name = var.bucket_name
}

module "Route53" {
    source = "./modules/Route53"

    website_domain_name = var.website_domain_name 
    S3_website_domain_name = module.S3_static_website_bucket.S3_website_domain_name # s3-website-us-east-1.amazonaws.com
}

module "ACM" {
    source = "./modules/ACM"

    website_domain_name = var.website_domain_name 
}