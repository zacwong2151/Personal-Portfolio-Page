terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Provider name
      version = "~> 5.92"       # Sets a version constraint for your AWS provider
    }
  }

  required_version = ">= 1.2" # Terraform version

  # This prompts Terraform to migrate my local terraform.tfstate file to the S3 bucket
  # This is so that no matter running `terraform apply` from your local CLI or through Github actions runner, the same state file is retrieved
  backend "s3" {
    bucket = "loonymoony-terraform-state-bucket" # Use the name of your new state bucket
    key    = "frontend/terraform.tfstate"        # The path within the bucket
    region = "us-east-1"                         # Must match your bucket's region
  }
}