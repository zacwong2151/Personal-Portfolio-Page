output "S3_website_domain_name" {
  description = "Domain of the website endpoint. This is used to create Route 53 alias records."
  value       = aws_s3_bucket_website_configuration.static_website_config.website_domain
}

output "S3_website_endpoint_URL" {
  description = "Domain name is the human-readable address, while endpoint URL is the full path that includes the protocol, domain name, and path"
  value       = aws_s3_bucket_website_configuration.static_website_config.website_endpoint
}