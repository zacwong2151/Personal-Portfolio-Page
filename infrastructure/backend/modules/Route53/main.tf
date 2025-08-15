# Retrieve the Hosted Zone ID for your 'loonymoony.click' domain
data "aws_route53_zone" "selected_zone" {
  name         = "${var.website_domain_name}."
  private_zone = false
}

# Create the Route 53 'A' record for the custom domain "api.loonymoony.click"
# This is the DNS record that points your custom domain name "api.loonymoony.click" to the API Gateway
resource "aws_route53_record" "api_domain_record" {
  zone_id = data.aws_route53_zone.selected_zone.zone_id
  name    = var.api_domain_name
  type    = "A"

  alias {
    name                   = var.API_GW_domain_name
    zone_id                = var.API_GW_zone_id
    evaluate_target_health = false
  }
}