output "vpc-id" {
  value = aws_vpc.customer_vpc.id
}

output "vpc-rt" {
  value = aws_vpc.customer_vpc.main_route_table_id
}

output "subnet-ids" {
  value = [for sub in aws_subnet.public_subnets : {
    id = sub.id  
    cidr = sub.cidr_block
}]
}