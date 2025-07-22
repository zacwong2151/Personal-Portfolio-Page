output "website_endpoint" {
  description = "The S3 static website endpoint URL."
  value       = aws_s3_bucket_website_configuration.static_website_config.website_endpoint
}

output "route53_record_name" {
  description = "The Route 53 A record name."
  value       = aws_route53_record.www_alias.fqdn # Fully Qualified Domain Name
}