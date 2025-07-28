variable "dynamodb_table_name" {
  description = "The name of the DynamoDB VisitorCount table."
  type        = string
  default     = "VisitorCount"
}

variable "website_domain_name" {
  description = "The website address"
  type        = string
  default     = "loonymoony.click"
}