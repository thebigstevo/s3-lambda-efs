# IAM Role for Lambda Function
resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_efs_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow"
      }
    ]
  })
}

# IAM Policy for Lambda
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_s3_efs_policy"
  description = "Policy for Lambda to access S3 and EFS"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "lambdavpcaccess",
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSubnets",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ],
        "Resource": "*"
      },
      {
        "Sid": "lambdaexecutionpolicy",
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "s3-object-lambda:WriteGetObjectResponse"
        ],
        "Resource": "*"
      },
      {
        "Sid": "s3bucketlist",
        "Effect": "Allow",
        "Action": [
          "s3:*"
        ],
        "Resource": [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      },
      {
        "Sid": "efsaccess",
        "Effect": "Allow",
        "Action": [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:ClientRootAccess",
          "elasticfilesystem:ClientRead",
          "elasticfilesystem:DescribeFileSystems",
          "elasticfilesystem:DescribeMountTargets"
        ],
        "Resource": "*"
      },
      {
        "Sid": "invokelambda",
        "Effect": "Allow",
        "Action": [
          "lambda:InvokeFunction"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Attach the IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "lambda_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
