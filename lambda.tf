# Lambda function
resource "aws_lambda_function" "s3tolambdatoefs" {
  function_name = "s3_to_lambda_to_efs"
  handler       = "s3_to_lambda_to_efs.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.9"
  filename      = "s3_to_lambda_to_efs.zip"
  timeout       = "900" # Increased to the maximum timeout
  memory_size   = "1024"

  source_code_hash = "s3_to_lambda_to_efs"
  vpc_config {
    security_group_ids = [aws_security_group.lambda_sg.id]
    subnet_ids         = [
      aws_subnet.public-subnet-1.id,
      aws_subnet.public-subnet-2.id,
      aws_subnet.public-subnet-3.id
    ]
  }

  environment {
    variables = {
      aws_efs_access_point = aws_efs_access_point.efs_ap.id
    }
  }

  file_system_config {
    arn              = aws_efs_access_point.efs_ap.arn
    local_mount_path = "/mnt/"
  }

  depends_on = [
    aws_efs_access_point.efs_ap,
    aws_efs_mount_target.efs_mt-1,
    aws_efs_mount_target.efs_mt-2,
    aws_efs_mount_target.efs_mt-3,
    aws_efs_file_system.efs_vol
  ]
}

# Lambda permissions for S3
resource "aws_lambda_permission" "with_s3" {
  statement_id  = "s3invokelambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3tolambdatoefs.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.receiving_bucket.arn
}
