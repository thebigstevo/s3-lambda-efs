resource "aws_lambda_function" "s3tolambdatoefs" {
  function_name = "s3_to_lambda_to_efs"
  handler       = "s3tolambdatoefs.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.8"
  filename      = "s3_to_lambda_to_efs.zip"
  timeout       = "20"

  source_code_hash = filebase64sha256("s3_to_lambda_to_efs.zip")
  vpc_config {
    security_group_ids = [aws_security_group.efs_sg.id]
    # Option 1: Using Indexing
    # subnet_ids= [data.aws_subnet.mysubnet[0].id, data.aws_subnet.mysubnet[1].id, ...]

    # Option 2: Using for expression
    subnet_ids = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id, aws_subnet.public-subnet-3.id]
  }
  environment {
    variables = {
      aws_efs_access_point = aws_efs_access_point.efs_ap.id
    }
  }
  file_system_config {
    arn              = aws_efs_access_point.efs_ap.arn
    local_mount_path = "/mnt/efs"

  }
}

resource "aws_lambda_permission" "with_s3" {
  statement_id  = "s3invokelambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3tolambdatoefs.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.receiving_bucket.arn
}

