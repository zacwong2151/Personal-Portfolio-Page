terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Provider name
      version = "~> 5.92"       # Sets a version constraint for your AWS provider
    }
  }

  required_version = ">= 1.2" # Terraform version
}