# EFS security group
resource "aws_security_group" "efs_sg" {
  name_prefix = "efs_sg"
  vpc_id      = aws_vpc.s3toefs-vpc.id
  description = "EFS security group"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.s3toefs-vpc.cidr_block]  # Allow traffic from within the VPC
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
  vpc_id      = aws_vpc.s3toefs-vpc.id
  description = "Lambda security group"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.s3toefs-vpc.cidr_block]  # Allow traffic from within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
