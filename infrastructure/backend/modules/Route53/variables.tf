variable "website_domain_name" {
  description = "Your website's domain name for CORS."
  type        = string
}

variable "api_domain_name" {
  description = "The custom API domain name"
  type        = string
}

variable "API_GW_domain_name" {
  description = "Target domain name of the API Gateway"
  type        = string
}

variable "API_GW_zone_id" {
  description = "Hosted zone ID of the API Gateway"
  type        = string
}