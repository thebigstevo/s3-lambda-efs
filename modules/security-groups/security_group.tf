# EFS security group
resource "aws_security_group" "efs_sg" {
  name_prefix = "efs_sg"
  vpc_id      = var.vpc_id
  description = "EFS security group"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr ]  # Allow traffic from within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#EC2 Security group
resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2_sg"
  vpc_id      = var.vpc_id
  description = "EFS security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from from outside the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}
# Lambda security group
resource "aws_security_group" "lambda_sg" {
  name_prefix = "lambda_sg"
  vpc_id      = var.vpc_id
  description = "Lambda security group"

  # ingress {
  #   from_port   = 2049
  #   to_port     = 2049
  #   protocol    = "tcp"
  #   cidr_blocks = [var.vpc_cidr ]  # Allow traffic from within the VPC
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
