# Configure the AWS Provider
provider "aws" {
  profile = "admin-zac-development"
  region  = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
}

module "DynamoDB" {
  source = "./modules/DynamoDB"

  dynamodb_table_name = var.dynamodb_table_name
}