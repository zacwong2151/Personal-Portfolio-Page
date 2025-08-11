# Create bucket
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = var.website_bucket_name
}

# Enable static website hosting
resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website_bucket.id

  index_document {
    suffix = "index.html"
  }
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
    sid = "AllowPublicAccessWithCustomHeader"

    effect = "Allow"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.static_website_bucket.arn}/*", # Apply to all objects in the bucket
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:Referer" # This checks the Referer header
      values   = [var.cloudfront_custom_header]
    }
  }

  statement {
    sid = "AllowAwsAccountAccess"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::852359052829:user/admin"] # Allows the admin IAM user of your AWS account
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      aws_s3_bucket.static_website_bucket.arn,        # for bucket-level actions (e.g. ListBucket)
      "${aws_s3_bucket.static_website_bucket.arn}/*", # for object-level actions
    ]
  }
}

# Attach the bucket policy to the bucket
resource "aws_s3_bucket_policy" "attach_bucket_policy" {
  bucket = aws_s3_bucket.static_website_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy.json
}

# Upload files to the S3 bucket
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "index.html"
  source       = "${var.web_files_path}/index.html"
  content_type = "text/html"
  etag         = filemd5("${var.web_files_path}/index.html") # Triggers update if file content changes

  # Explicit dependency to ensure bucket is ready before uploading
  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
    # aws_s3_bucket_public_access_block.public_access_config
  ]
}

resource "aws_s3_object" "error_html" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "error.html"
  source       = "${var.web_files_path}/error.html"
  content_type = "text/html"
  etag         = filemd5("${var.web_files_path}/error.html") # Triggers update if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
  ]
}

resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "style.css"
  source       = "${var.web_files_path}/style.css"
  content_type = "text/css"
  etag         = filemd5("${var.web_files_path}/style.css") # Triggers update if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
  ]
}

resource "aws_s3_object" "koala_pic" {
  bucket       = aws_s3_bucket.static_website_bucket.id
  key          = "koala.jpg"
  source       = "${var.web_files_path}/koala.jpg"
  content_type = "image/jpeg"
  etag         = filemd5("${var.web_files_path}/koala.jpg") # Triggers update if file content changes

  depends_on = [
    aws_s3_bucket_website_configuration.static_website_config,
    aws_s3_bucket_policy.attach_bucket_policy,
  ]
}

# Another S3 bucket to store frontend infra terraform state file, so that your local machine and the GitHub Actions runner reads the same terraform.tfstate file
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.terraform_state_bucket_name
}

# Enable versioning so that you can recover previous versions of your state file in case of accidental corruption or deletion
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}