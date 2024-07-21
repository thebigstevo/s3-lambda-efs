# ------------------------------------------------------------------------------
# IAM for Lambda function
# ------------------------------------------------------------------------------

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
# IAM Policy for Lambda Function
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_s3_efs_policy"
  description = "Policy for Lambda to access S3 and EFS"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "CloudWatchLogs",
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "VPCNetwork",
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "S3Access",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        "Resource" : [
          "${var.s3_bucket_arn}",
          "${var.s3_bucket_arn}/*"
        ]
      },
      {
        "Sid" : "EFSAccess",
        "Effect" : "Allow",
        "Action" : [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientWrite",
          "elasticfilesystem:DescribeMountTargets"
        ],
        "Resource" : "${var.efs_access_point_arn}"
      }
    ]
  })
}
# Attach the IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "lambda_role_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}



# # ------------------------------------------------------------------------------
# # IAM for Instance Connect
# # ------------------------------------------------------------------------------

# resource "aws_iam_role" "instance_connect" {
#   name        = "instance-connect"
#   description = "Iam role for instance connect access"
#   assume_role_policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Action" : "sts:AssumeRole",
#         "Principal" : {
#           "Service" : ["ec2.amazonaws.com", "ssm.amazonaws.com"]
#         },
#         "Effect" : "Allow"
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "instance_connect_policy" {
#   name        = "lambda_s3_efs_policy"
#   description = "Policy for Lambda to access S3 and EFS"
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : "ec2-instance-connect:SendSSHPublicKey",
#         "Resource" : "${aws_instance.instance_connect.arn}",
#         "Condition" : {
#           "StringEquals" : { "ec2:osuser" : "ec2-user" }
#         }
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : "ec2:DescribeInstances",
#         "Resource" : "*"
#       }
#     ]
#   })
# }
# resource "aws_iam_role_policy_attachment" "instance_connect_policy_attachment" {
#   role       = aws_iam_role.instance_connect.name
#   policy_arn = aws_iam_policy.instance_connect_policy.arn
# }