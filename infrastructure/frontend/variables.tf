variable "website_bucket_name" {
  description = "The name for the S3 bucket for static website hosting"
  type        = string
  default     = "loonymoony.click"
}

variable "website_domain_name" {
  description = "The website address"
  type        = string
  default     = "loonymoony.click"
}

variable "terraform_state_bucket_name" {
  description = "The name of the bucket used to store the terraform state file"
  type        = string
  default     = "loonymoony-terraform-state-bucket"
}

variable "web_files_path" {
  description = "Relative path from the project root to the dist folder. Terraform's path resolution for the source argument is relative to the root module where terraform apply is executed, not the module file itself."
  type        = string
  default     = "../../frontend/dist"
}