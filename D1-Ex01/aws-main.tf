
resource "aws_vpc" "vpc1" {
    cidr_block = "10.20.0.0/16"
    tags = {
      "Name" = "VPC1"
      "Env" = "Dev"
      "Dep" = "finance"
    }
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.20.1.0/24"
    tags = {
      "Name" = "sub1"
      "Env" = "Dev"
      "Dep" = "finance"
    }
}