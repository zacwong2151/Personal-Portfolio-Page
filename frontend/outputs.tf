output "S3_website_domain_name" {
  description = "The S3 static website domain name."
  value       = module.S3_static_website_bucket.S3_website_domain_name
}

output "S3_website_endpoint" {
  description = "The S3 static website endpoint URL. Comprises of the protocol, domain name, and path"
  value       = module.S3_static_website_bucket.S3_website_endpoint
}

output "S3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.S3_static_website_bucket.S3_bucket_arn
}

output "cloudfront_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = module.CloudFront.cloudfront_arn
}

output "cloudfront_id" {
  description = "The ID of the CloudFront distribution."
  value       = module.CloudFront.cloudfront_id
}

output "cloudfront_domain_name" {
  description = "The default domain name given to a CloudFront distribution"
  value       = module.CloudFront.cloudfront_domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2"
  value       = module.CloudFront.cloudfront_hosted_zone_id
}

output "route53_record_name" {
  description = "The Route 53 A record name."
  value       = module.Route53.route53_record_name
}

