#vpc-id = "vpc-0ae4f11068d2a2dff"


resource "aws_vpc" "vpc" {
    count = var.enablevpc == true ? 1 : "0"
    provider = aws.aws_dev
    cidr_block = var.vpc_cidr
    tags = {
      "Name" = var.vpc_name
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
  lifecycle {
    create_before_destroy = true
  }
}


# this is for map of string 
resource "aws_subnet" "subnets" {

  for_each = var.subnets
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc[0].id
  cidr_block = each.value
    tags = {
      "Name" = each.key
      "Env" = var.tag_env
      "Dep" = var.tag_dep
      "owner" = "Vishwa"
    }
  #lifecycle {
  #  create_before_destroy = true
    #prevent_destroy = true
  #}
}

resource "aws_instance" "name" {
  count = var.enable_instance == true ? 1 : "0"
  instance_type = "t2.micro"
  ami = "ami-234523abcd"
}

resource "aws_lb" "name" {
    count = var.enable_lb == true ? 1 : "0"
    subnets = [ aws_subnet.subnets["sub1"] ]
}


output "subnet-ids" {
  value = [for sub in aws_subnet.subnets : {
    id = sub.id  
    cidr = sub.cidr_block
}]
}


