resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_efs_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_s3_efs_policy"
  description = "Policy for Lambda to access S3 and EFS"
  policy = jsonencode({
    Version= "2012-10-17",
    Statement= [
      {
        Effect="Allow",
        Action= [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource= "*"
      },
      {
        Effect= "Allow",
        Action= [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite"
        ],
        Resource= "*"
      },
      { 
        Effect= "Allow", 
        Action= [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
            "logs:CreateLogGroup", 
        ],
            
        Resource= "*"
             }
      
    ]
  }
  )
}

resource "aws_iam_role_policy_attachment" "lambda_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}