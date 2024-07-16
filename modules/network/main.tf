# VPC
resource "aws_vpc" "s3toefs-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Subnets
resource "aws_subnet" "public-subnet-1" {
  cidr_block        = var.subnet-1-cidr
  vpc_id            = aws_vpc.s3toefs-vpc.id
  availability_zone = var.availability-zone-1
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-subnet-1"
  }
}

resource "aws_subnet" "public-subnet-2" {
  cidr_block        = var.subnet-2-cidr
  vpc_id            = aws_vpc.s3toefs-vpc.id
  availability_zone = var.availability-zone-2
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}

resource "aws_subnet" "public-subnet-3" {
  cidr_block        = var.subnet-3-cidr
  vpc_id            = aws_vpc.s3toefs-vpc.id
  availability_zone = var.availability-zone-3
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-subnet-3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.s3toefs-vpc.id
  tags = {
    Name = "${var.project_name}-internet-gateway"
  }
}

# Route Table for Public Subnets
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
# Route Table Association
resource "aws_route_table_association" "subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}

resource "aws_route_table_association" "subnet-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}

resource "aws_route_table_association" "subnet-3-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-3.id
}


