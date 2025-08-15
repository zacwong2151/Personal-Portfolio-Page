# Configure the AWS Provider
provider "aws" {
  #   profile = "admin-zac-development" # Removed so that this AWS provider block is agnostic to the credential source (which could be your local CLI, or the Github Actions runner)
  region = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
}

module "ACM" {
  source = "./modules/ACM"

  website_domain_name = var.website_domain_name
  api_domain_name     = var.api_domain_name
}

module "DynamoDB" {
  source = "./modules/DynamoDB"
}

module "Lambda" {
  source = "./modules/Lambda"

  visitor_count_table_arn   = module.DynamoDB.visitor_count_table_arn
  unique_visitors_table_arn = module.DynamoDB.unique_visitors_table_arn
}

module "API-Gateway" {
  source = "./modules/API-Gateway"

  api_domain_name     = var.api_domain_name
  website_domain_name = var.website_domain_name
  lambda_function_arn = module.Lambda.lambda_function_arn
  acm_cert_arn        = module.ACM.acm_cert_arn
}

module "Route53" {
  source = "./modules/Route53"

  website_domain_name = var.website_domain_name
  api_domain_name     = var.api_domain_name
  API_GW_domain_name  = module.API-Gateway.API_GW_domain_name
  API_GW_zone_id      = module.API-Gateway.API_GW_zone_id
}