# Configure the AWS Provider
provider "aws" {
  profile = "admin-zac-development"
  region  = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
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

  website_domain_name = var.website_domain_name
  lambda_function_arn = module.Lambda.lambda_function_arn
}