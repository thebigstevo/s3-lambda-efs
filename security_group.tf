#EFS security group
resource "aws_security_group" "efs_sg" {
  name_prefix = "efs_sg"
  vpc_id      = aws_vpc.s3toefs-vpc.id
  description = "EFS security group"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.s3toefs-vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "ec2-sg" {
  vpc_id      = var.vpc_id
  name        = "ec2-sg"
  description = "EC2 security group"
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "lambda_sg" {
  name_prefix = "lambda_sg"
  vpc_id      = aws_vpc.s3toefs_vpc.id
  description = "Lambda security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
