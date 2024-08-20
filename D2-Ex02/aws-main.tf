
resource "aws_vpc" "vpc1" {
    provider = aws.aws_dev
    cidr_block = var.vpc_cidr
    tags = {
      "Name" = var.vpc_name
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}

resource "aws_subnet" "sub1" {
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.sub_cidr
    tags = {
      "Name" = var.sub_name
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}
