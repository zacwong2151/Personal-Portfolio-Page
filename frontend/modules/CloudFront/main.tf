resource "aws_cloudfront_distribution" "cf_distribution" {
  enabled         = true # Whether the distribution is enabled to accept end user requests for content
  is_ipv6_enabled = true

  # For S3 static website hosting, the origin must be the S3 bucket's website endpoint, not the bucket endpoint
  origin {
    domain_name = var.S3_website_endpoint                # your S3 bucket website endpoint
    origin_id   = "S3-Website-Origin-${var.bucket_name}" # Unique identifier for the origin

    # Since S3 static website hosting behaves as a custom origin, you need custom origin configuration
    custom_origin_config {
      http_port  = 80  # HTTP port the custom origin listens on.
      https_port = 443 # HTTPS port the custom origin listens on.

      origin_protocol_policy = "http-only" # CloudFront will use HTTP to communicate with the S3 static website endpoint. Cannot be changed for custom origins.
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "Referer"
      value = var.cloudfront_custom_header
    }
  }

  # Define the default behavior for caching and routing requests.
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]             # Controls which HTTP methods CloudFront processes and forwards to your custom origin
    cached_methods   = ["GET", "HEAD", "OPTIONS"]             # HTTP methods for which CloudFront will cache responses
    target_origin_id = "S3-Website-Origin-${var.bucket_name}" # ID for the origin that you want CloudFront to route requests to

    # Policy for how viewers access the content:
    # "redirect-to-https" forces all HTTP requests to be redirected to HTTPS.
    viewer_protocol_policy = "redirect-to-https"

    # Minimum, default, and maximum time-to-live (TTL) for cached objects in seconds.
    min_ttl     = 0
    default_ttl = 86400    # 24 hours
    max_ttl     = 31536000 # 1 year

    # Enable Gzip compression for supported file types.
    compress = true

    # Field-level encryption is not needed for a public static website.
    field_level_encryption_id = ""

    # Specifies how CloudFront handles query strings, cookies and headers
    forwarded_values {
      query_string = false # Do not forward query strings to the origin (typical for static sites).
      cookies {            # Do not forward cookies to the origin.
        forward = "none"
      }
      headers = [] # Do not forward any specific headers to the origin.
    }
  }

  # Define restrictions for the distribution.
  restrictions {
    geo_restriction {
      restriction_type = "none" # Allow access from all geographic locations.
    }
  }

  # Associate the ACM cert for HTTPS with your custom domain.
  viewer_certificate {
    acm_certificate_arn      = var.acm_cert_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021" # Minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections
  }

  # Associate your custom domain name with the CloudFront distribution.
  aliases = [var.website_domain_name]

  # The default object that CloudFront returns when a viewer requests the root URL.
  default_root_object = "index.html"

  # Custom error response to redirect 404s to error.html
  custom_error_response {
    error_code            = 404
    response_page_path    = "/error.html"
    response_code         = 200
    error_caching_min_ttl = 0 # Optional: How long CloudFront should cache the error response. For SPAs, a low TTL (e.g., 0) is often preferred to ensure client-side routing works.
  }
}
