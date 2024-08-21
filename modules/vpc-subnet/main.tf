locals {
  commonpart = "${var.tag_env}-c1"
}


resource "aws_vpc" "vpc" {
    provider = aws.aws_dev
    cidr_block = var.vpc_cidr
    tags = {
      "Name" = "${var.vpc_name}-${local.commonpart}"
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}

# this is for map of string 
resource "aws_subnet" "subnets" {
  for_each = var.subnets
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value
    tags = {
      "Name" = "${each.key}-${local.commonpart}"
      "Env" = var.tag_env
      "Dep" = var.tag_dep
      "owner" = "Vishwa"
    }
}

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

