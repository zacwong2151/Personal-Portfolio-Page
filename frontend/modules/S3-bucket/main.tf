# Create bucket
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.bucket_name
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rules = jsonencode([
    {
      Condition = {
        HttpErrorCodeReturnedEquals = "404"
      }
      Redirect = {
        ReplaceKeyWith = "error.html"
      }
    }
  ])
}

# Allow public access to bucket
resource "aws_s3_bucket_public_access_block" "public_access_config" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Create bucket policy
data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "Only allow your CloudFront distribution to access this bucket"

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.static_website_bucket.arn}/*", # Apply to all objects in the bucket
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_arn]
    }
  }

  statement {
    sid = "Explicitly deny public access to S3"

    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.static_website_bucket.arn}/*",
    ]

    # This condition ensures the denial applies to requests NOT coming from your CloudFront distribution
    condition {
      test     = "StringNotEquals"
      variable = "AWS:SourceArn"
      values   = [var.cloudfront_arn]
    }
  }
}

# Attach the bucket policy to the bucket
resource "aws_s3_bucket_policy" "attach_bucket_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

# Upload files to the S3 bucket. By using ${path.module}, you explicitly tell Terraform to look for the file relative to the S3-bucket directory
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "index.html"
  source       = "${path.module}/web-files/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/web-files/index.html") # Triggers update if file content changes

  # Explicit dependency to ensure bucket is ready before uploading
  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
    aws_s3_bucket_public_access_block.public_access_config
  ]
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "error.html"
  source       = "${path.module}/web-files/error.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/web-files/error.html") # Triggers update if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
    aws_s3_bucket_public_access_block.public_access_config
  ]
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "style.css"
  source       = "${path.module}/web-files/style.css"
  content_type = "text/css"
  etag         = filemd5("${path.module}/web-files/style.css") # Triggers update if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
    aws_s3_bucket_public_access_block.public_access_config
  ]
}