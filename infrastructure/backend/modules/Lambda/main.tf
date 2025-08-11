# Trust policy
data "aws_iam_policy_document" "lambda_trust_policy" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Permissions policy
resource "aws_iam_policy" "lambda_permissions_policy" {
  name = "access-dynamodb-table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:UpdateItem",
          "dynamodb:GetItem",
          "dynamodb:PutItem",
        ]
        Resource = [
          var.visitor_count_table_arn,
          var.unique_visitors_table_arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"

      }
    ]
  })
}

# Create Lambda execution role and attach trust policy
resource "aws_iam_role" "lambda_execution_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.lambda_trust_policy.json
}

# Attach permissions policy to Lambda role
resource "aws_iam_role_policy_attachment" "lambda_permissions_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_permissions_policy.arn
}

# Package the Lambda function code and its dependencies (which are stored in node_modules)
data "archive_file" "lambda_code" {
  type        = "zip" # generates a zip file
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/lambda/function.zip"
  excludes = [ # only zips the /node_modules folder, index.js, util.js, and package.json
    "*.zip",
    "package-lock.json"
  ]
}

# Create Lambda function
resource "aws_lambda_function" "lambda_function" {
  filename         = data.archive_file.lambda_code.output_path         # Path to the function's deployment package within the local filesystem
  function_name    = "visitor-count-incrementor"                       # Unique name for your Lambda Function
  role             = aws_iam_role.lambda_execution_role.arn            # ARN of the function's execution role.
  handler          = "index.handler"                                   # Function entry point in your code. Required if package_type is Zip
  source_code_hash = data.archive_file.lambda_code.output_base64sha256 # Base64-encoded SHA256 hash of the package file. Used to trigger updates when source code changes

  runtime = "nodejs20.x" # Function's runtime environment
}