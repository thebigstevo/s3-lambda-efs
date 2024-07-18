output "lambda_arn" {
  value = aws_lambda_function.s3tolambdatoefs.arn
}

output "function_name" {
  value = aws_lambda_function.s3tolambdatoefs.function_name
}

