# Lambda function
resource "aws_lambda_function" "s3tolambdatoefs" {
  function_name = "s3_to_lambda_to_efs"
  handler       = "s3_to_lambda_to_efs.lambda_handler"
  role          = var.lambda_role_arn
  runtime       = "python3.10"
  filename      = "${path.module}/s3_to_lambda_to_efs.zip"
  source_code_hash = filebase64sha256("${path.module}/s3_to_lambda_to_efs.zip")



  timeout       = "120"
  memory_size   = "128"
  vpc_config {
    security_group_ids = [var.lambda_security_group_ids]
    subnet_ids         = [
      var.public_subnet_1_id,
      var.public_subnet_2_id,
      var.public_subnet_3_id
    ]
  }

  environment {
    variables = {
      aws_efs_access_point = var.lambda_security_group_ids
    }
  }

  file_system_config {
    arn              = var.efs_access_point_arn
    local_mount_path = "/mnt/efs"
  }
}



# Lambda permissions for S3
resource "aws_lambda_permission" "with_s3" {
  statement_id  = "s3invokelambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3tolambdatoefs.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}