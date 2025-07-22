output "website_endpoint" {
  description = "The S3 static website endpoint URL."
  value       = aws_s3_bucket_website_configuration.static_website_config.website_endpoint
}