output "vpc_id"{
    description= "vpc ID"
    value = aws_vpc.s3toefs-vpc.id
}

output route_table_id {
    description= "route table ID"
    value = aws_route_table.public-route-table.id
}