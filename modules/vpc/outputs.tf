output "vpc_id"{
    description= "vpc ID"
    value = aws_vpc.s3toefs-vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet[0].id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet[1].id
}

output "public_subnet_3_id" {
  value = aws_subnet.public_subnet[2].id
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}