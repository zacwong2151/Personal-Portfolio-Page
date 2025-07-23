output "route53_record_name" {
  description = "The Route 53 A record name."
  value       = aws_route53_record.alias.fqdn # Fully Qualified Domain Name
}