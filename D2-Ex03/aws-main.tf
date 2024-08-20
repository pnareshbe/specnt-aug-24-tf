
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
  count = length(var.sub_cidr)
  provider = aws.aws_dev
  vpc_id = aws_vpc.vpc1.id
  cidr_block = var.sub_cidr[count.index]
    tags = {
      "Name" = var.sub_name[count.index]
      "Env" = var.tag_env
      "Dep" = var.tag_dep
    }
}

output "subents-id" {
  value = aws_subnet.sub1[*].id
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