output "vpc_id"{
    description= "vpc ID"
    value = aws_vpc.s3toefs-vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public-subnet-1.id
}
output "public_subnet_2_id" {
  value = aws_subnet.public-subnet-2.id
}
output "public_subnet_3_id" {
  value = aws_subnet.public-subnet-3.id
}

output route_table_id {
    description= "route table ID"
    value = aws_route_table.public-route-table.id
}

output "vpc_cidr" {
  value = var.vpc_cidr
}