# Retrieve the Hosted Zone ID for your 'loonymoony.click' domain
data "aws_route53_zone" "selected_zone" {
  name         = "${var.website_domain_name}."
  private_zone = false
}

# Create the A record for the root domain 'loonymoony.click'
resource "aws_route53_record" "alias" {
  zone_id = data.aws_route53_zone.selected_zone.zone_id
  name    = var.website_domain_name # The root domain
  type    = "A"

  # Create an Alias to the CloudFront distribution
  alias {
    name                   = var.cloudfront_domain_name # The unique domain name that AWS assigns to your distribution (e.g. d3l36qw5i665a3.cloudfront.net)
    zone_id                = var.cloudfront_hosted_zone_id
    evaluate_target_health = true # Set to true to allow Route 53 to check the health of the target
  }
}