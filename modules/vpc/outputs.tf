output "vpc_id"{
    description= "vpc ID"
    value = aws_vpc.s3toefs-vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}
output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}