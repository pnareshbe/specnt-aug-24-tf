
resource "aws_vpc" "vpc1" {
    provider = aws.aws_dev
    cidr_block = "10.20.0.0/16"
    tags = {
      "Name" = "VPC1"
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}

resource "aws_subnet" "sub1" {
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.20.1.0/24"
    tags = {
      "Name" = "sub1"
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}

resource "aws_vpc" "vpc_prod" {
  provider = aws.aws_prod
    cidr_block = "10.30.0.0/16"
    tags = {
      "Name" = "VPC_prod"
      "Env" = "prod"
      #"Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}