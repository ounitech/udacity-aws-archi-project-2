# TODO: Define the output variable for the lambda function.
output "udacity-lamdba-id" {
  value = aws_lambda_function.udacity-lambda.id
}

output "udacity-lambda-arn" {
  value = aws_lambda_function.udacity-lambda.arn
}