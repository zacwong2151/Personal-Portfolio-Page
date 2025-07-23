output "S3_website_domain_name" {
  description = "The S3 static website domain name."
  value       = module.S3_static_website_bucket.S3_website_domain_name
}

output "S3_website_endpoint_URL" {
  description = "The S3 static website endpoint URL. Comprises of the protocol, domain name, and path"
  value       = module.S3_static_website_bucket.S3_website_endpoint_URL
}

output "route53_record_name" {
  description = "The Route 53 A record name."
  value       = module.Route53.route53_record_name
}