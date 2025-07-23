# Requests a certicate from ACM
resource "aws_acm_certificate" "acm_cert" {
  domain_name       = var.website_domain_name
  validation_method = "DNS"
}

# Retrieve the Hosted Zone ID for your 'loonymoony.click' domain
data "aws_route53_zone" "selected_zone" {
  name         = var.website_domain_name
  private_zone = false
}

/*
    This is the correct and most robust way to handle ACM's domain_validation_options. An ACM certificate can sometimes require multiple
     CNAME records for validation (e.g., if you request a wildcard certificate like *.example.com and example.com, or if you have multiple
      SANs - Subject Alternative Names). for_each dynamically creates a Route 53 record for each required validation option.
*/
resource "aws_route53_record" "route53_records" {
  for_each = {
    for dvo in aws_acm_certificate.acm_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.selected_zone.zone_id
}

# This resource represents a successful validation of an ACM certificate
resource "aws_acm_certificate_validation" "acm_cert_validation" {
  certificate_arn = aws_acm_certificate.acm_cert.arn

  /*
    This is the key for validation. It waits for the CNAME records created by aws_route53_record to propagate and for ACM to
     successfully validate the certificate. This for loop dynamically collects the fqdn (fully qualified domain name) of all the
      records created by for_each, ensuring all required validation records are present and confirmed
  */
  validation_record_fqdns = [for record in aws_route53_record.route53_records : record.fqdn]
}