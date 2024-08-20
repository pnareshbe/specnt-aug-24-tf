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
    }
}

# this is for map of objects 
resource "aws_subnet" "subnets1" {
  for_each = var.subnets1
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc.id

    cidr_block = each.value.cidr_block
    availability_zone = each.value.availability_zone
      tags = {
        "Name" = each.value.name
        "Env" = var.tag_env
        "Dep" = var.tag_dep
      }
    
}
# this is for map of objects 


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

output "subnet-idsss" {
  value = {for key,  sub in aws_subnet.subnets : key =>  {
    id = sub.id  
    cidr = sub.cidr_block
}}
}

#for (i=0, i<2, i++)

/*resource "aws_subnet" "sub2" {
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.sub_cidr2
    tags = {
      "Name" = var.sub_name2
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}*/