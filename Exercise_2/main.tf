provider "aws" {
  access_key = var.aws-access-key
  secret_key = var.aws-secret-key
  region     = var.aws-region
}

data "archive_file" "dummy" {
  source_file = "greet_lambda.py"
  output_path = "greet.zip"
  type        = "zip"
}

resource "aws_iam_role" "udacity-lambda-role" {
  name               = "udacity-lambda-role"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.udacity-lambda-role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_lambda_function" "udacity-lambda" {
  function_name = "udacity-lambda"
  role          = aws_iam_role.udacity-lambda-role.arn
  filename      = data.archive_file.dummy.output_path
  handler       = "greet_lambda.lambda_handler"
  runtime       = "python3.9"
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs
  ]
  environment {
    variables = {
      "greeting" = "ounitech"
    }
  }
}