output "vpc-id" {
  value = aws_vpc.vpc.id
}

output "vpc-rt" {
  value = aws_vpc.vpc.main_route_table_id
}

output "subnet-ids" {
  value = [for sub in aws_subnet.subnets : {
    id = sub.id  
    cidr = sub.cidr_block
}]
}