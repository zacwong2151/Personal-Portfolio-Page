# Retrieve the Hosted Zone ID for your 'loonymoony.click' domain
data "aws_route53_zone" "selected_zone" {
  name         = "${var.website_domain_name}."
  private_zone = false
}

# Request an SSL certificate for your "api.loonymoony.click" custom domain
resource "aws_acm_certificate" "api_cert" {
  domain_name       = var.api_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# Create the DNS record for ACM certificate validation
# This resource creates the CNAME record in your hosted zone to validate ownership of the domain.
resource "aws_route53_record" "api_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.api_cert.domain_validation_options : dvo.domain_name => dvo
  }

  /*
    Domain validation objects export the following attributes:

    domain_name - Domain to be validated
    resource_record_name - The name of the DNS record to create to validate the certificate
    resource_record_type - The type of DNS record to create
    resource_record_value - The value the DNS record needs to have
*/
  zone_id = data.aws_route53_zone.selected_zone.zone_id # Hosted zone ID
  name    = each.value.resource_record_name
  type    = each.value.resource_record_type
  records = [each.value.resource_record_value]
  ttl     = 60
}

# This resource represents a successful validation of an ACM certificate
resource "aws_acm_certificate_validation" "api_cert_validation" {
  certificate_arn         = aws_acm_certificate.api_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.api_cert_validation_record : record.fqdn]
}

