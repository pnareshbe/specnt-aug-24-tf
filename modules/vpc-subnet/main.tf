locals {
  commonpart = "${var.tag_env}-c1"
}

# VPC, Multiple subnets, IGW, New Route Table and Subnet association

resource "aws_vpc" "customer_vpc" {
    #provider = aws.aws_dev
    cidr_block = var.vpc_cidr
    tags = {
      "Name" = "${var.vpc_name}-${local.commonpart}"
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}

/*# VPC
resource "aws_vpc" "customer_vpc" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, { Name = "customer-vpc" })
}
# this is for map of string 
resource "aws_subnet" "subnets" {
  for_each = var.subnets
  #provider = aws.aws_dev
  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value
    tags = {
      "Name" = "${each.key}-${local.commonpart}"
      "Env" = var.tag_env
      "Dep" = var.tag_dep
      "owner" = "Vishwa"
    }
}*/


resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnets

  #provider = aws.aws_dev
  vpc_id   = aws_vpc.customer_vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags =  merge(var.tags, { Name = each.value.name, Owner = "Vishwa" })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  count = var.enable_ig ? 1 : 0
  vpc_id = aws_vpc.customer_vpc.id
  tags = merge(var.tags, { Name = "customer-igw" })
}

# Route Table
resource "aws_route_table" "public_rt" {
  count = var.enable_ig ? 1 : 0
  vpc_id = aws_vpc.customer_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw[0].id
  }
  tags = merge(var.tags, { Name = "public-route-table" })
}

# Associate the route table with the first subnet
resource "aws_route_table_association" "public_rt_association" {
  count = var.enable_ig ? 1 : 0
  subnet_id      = aws_subnet.public_subnets["sub1"].id
  route_table_id = aws_route_table.public_rt[0].id
}
