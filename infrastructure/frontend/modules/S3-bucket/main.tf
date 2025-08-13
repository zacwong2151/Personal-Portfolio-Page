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

# Upload the entire contents of the 'dist' folder to the S3 bucket
# This dynamically creates an aws_s3_object for every file and subdirectory within your dist folder
resource "aws_s3_object" "website_files" {
  for_each = fileset("${var.web_files_path}", "**")

  bucket = aws_s3_bucket.static_website_bucket.id
  key    = each.value
  source = "${var.web_files_path}/${each.value}"

  # Set the content type based on the file extension
  content_type = try(
    lookup({
      "html"  = "text/html",
      "css"   = "text/css",
      "js"    = "application/javascript",
      "json"  = "application/json",
      "png"   = "image/png",
      "jpg"   = "image/jpeg",
      "jpeg"  = "image/jpeg",
      "gif"   = "image/gif",
      "svg"   = "image/svg+xml",
      "ico"   = "image/x-icon",
      "woff"  = "font/woff",
      "woff2" = "font/woff2",
      "ttf"   = "font/ttf",
      "eot"   = "application/vnd.ms-fontobject",
      "otf"   = "font/otf"
    }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream"),
    "application/octet-stream"
  )
  etag = filemd5("${var.web_files_path}/${each.value}")
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