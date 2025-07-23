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

  # Alias record configuration
  alias {
    name = var.S3_website_domain_name # This is the S3 website domain name, not just "loonymoony.click"
    zone_id = var.hosted_zone_id_us-east-1
    evaluate_target_health = true # Set to true to allow Route 53 to check the health of the target
  }
}