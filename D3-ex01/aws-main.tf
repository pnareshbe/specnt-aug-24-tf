data "aws_vpc" "vpc-id" {

  tags = {
    Name   = "vpc1-dev-c1"
  }
  #filter {
  #  name = "tag:name"
  #  values = ["vpc1"]
  #}
}
#vpc-id = "vpc-0ae4f11068d2a2dff"

# this is for map of string 
resource "aws_subnet" "subnets" {
  for_each = var.subnets
  provider = aws.aws_dev
  vpc_id = data.aws_vpc.vpc-id
  cidr_block = each.value
    tags = {
      "Name" = each.key
      "Env" = var.tag_env
      "Dep" = var.tag_dep
      "owner" = "Vishwa"
    }
}

output "subnet-ids" {
  value = [for sub in aws_subnet.subnets : {
    id = sub.id  
    cidr = sub.cidr_block
}]
}


