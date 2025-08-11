output "S3_website_domain_name" { # loonymoony.click.s3-website-us-east-1.amazonaws.com
  description = "Domain of the website endpoint. This is used to create Route 53 alias records."
  value       = aws_s3_bucket_website_configuration.static_website_config.website_domain
}

output "S3_website_endpoint" { # http://loonymoony.click.s3-website-us-east-1.amazonaws.com
  description = "Domain name is the human-readable address, while endpoint URL is the full path that includes the protocol, domain name, and path"
  value       = aws_s3_bucket_website_configuration.static_website_config.website_endpoint
}

output "S3_website_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.static_website_bucket.arn
}