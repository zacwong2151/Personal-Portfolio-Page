# Configure the AWS Provider
provider "aws" {
  profile = "admin-zac-development"
  region  = "us-east-1" # Explicitly define the region, even if in profile, for clarity.
}

# Create bucket
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "TerraformStaticWebsite"
  }
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
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Create bucket policy
data "aws_iam_policy_document" "static_website_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"] # Allows access to all principals (public)
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.static_website_bucket.arn}/*",
    ]
  }
}

# Attach the bucket policy to the bucket
resource "aws_s3_bucket_policy" "static_website_bucket_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.static_website_policy.json
}

# Upload files to the S3 bucket
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "index.html"
  source       = "index.html" # Path to your local index.html file
  content_type = "text/html"
  etag         = filemd5("index.html") # Forces recreation if file content changes

  # Explicit dependency to ensure bucket is ready before uploading
  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.static_website_bucket_policy,
    aws_s3_bucket_public_access_block.example
  ]
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "error.html"
  source       = "error.html" # Path to your local error.html file
  content_type = "text/html"
  etag         = filemd5("error.html") # Forces recreation if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.static_website_bucket_policy,
    aws_s3_bucket_public_access_block.example
  ]
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "style.css"
  source       = "style.css" # Path to your local style.css file
  content_type = "text/css"
  etag         = filemd5("style.css") # Forces recreation if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.static_website_bucket_policy,
    aws_s3_bucket_public_access_block.example
  ]
}
