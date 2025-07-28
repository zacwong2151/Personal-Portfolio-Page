variable "visitor_count_table_name" {
  description = "The name of the DynamoDB VisitorCount table."
  type        = string
  default     = "VisitorCount"
}

variable "unique_visitors_table_name" {
  description = "The name of the DynamoDB UniqueVisitors table."
  type        = string
  default     = "UniqueVisitors"
}