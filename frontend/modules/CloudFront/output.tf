output "cloudfront_arn" {
  description = "The ARN of the CloudFront distribution."
  value       = aws_cloudfront_distribution.cf_distribution.arn
}

output "cloudfront_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.cf_distribution.id
}

output "cloudfront_domain_name" {
  description = "The default domain name given to a CloudFront distribution"
  value       = aws_cloudfront_distribution.cf_distribution.domain_name
}

output "cloudfront_hosted_zone_id" {
  description = "CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. This attribute is simply an alias for the zone ID Z2FDTNDATAQYW2"
  value       = aws_cloudfront_distribution.cf_distribution.hosted_zone_id
}