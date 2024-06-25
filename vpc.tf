resource "aws_vpc" "s3toefs-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name="${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  cidr_block = var.vpc_cidr
  vpc_id = aws_vpc.s3toefs-vpc.id
  availability_zone = var.availability-zone-1
  tags = {
    Name="${var.project_name}-public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block = var.vpc_cidr
  vpc_id = aws_vpc.s3toefs-vpc.id
  availability_zone = var.availability-zone-2
  tags = {
    Name="${var.project_name}-public-subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  cidr_block = var.vpc_cidr
  vpc_id = aws_vpc.s3toefs-vpc.id
  availability_zone = var.availability-zone-3
  tags = {
    Name="${var.project_name}-public-subnet-3"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.s3toefs-vpc.id
  tags = {
    Name = "${var.project_name}-internet-gateway"
  }
} 

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.s3toefs-vpc.id
  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

resource "aws_route_table_association" "subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "subnet-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-2.id
}

resource "aws_route_table_association" "subnet-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id = aws_subnet.public-subnet-3.id  
}


# #EFS security group
# resource "aws_security_group" "efs_sg" {
#   name_prefix = "efs_sg"
#   vpc_id      = data.aws_vpc.myvpc.id

#   ingress {
#     from_port   = 2049
#     to_port     = 2049
#     protocol    = "tcp"
#     cidr_blocks = [data.aws_vpc.myvpc.cidr_block]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# output "subnet_ids" {
#   value = data.aws_subnets.my_subnets.ids
# }
