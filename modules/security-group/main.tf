# Security Group
/*resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.customer_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "web-sg" })
}*/

resource "aws_security_group" "web_sg" {
  for_each = var.security_groups

  vpc_id = var.vpc-id

  dynamic "ingress" {
    for_each = each.value["ingress"]
    content {
      from_port   = ingress.value[0]
      to_port     = ingress.value[1]
      protocol    = ingress.value[2]
      cidr_blocks = ingress.value[3]
    }
  }

  dynamic "egress" {
    for_each = each.value["egress"]
    content {
      from_port   = egress.value[0]
      to_port     = egress.value[1]
      protocol    = egress.value[2]
      cidr_blocks = egress.value[3]
    }
  }

  tags = merge(var.tags, { Name = each.value.name })
}
