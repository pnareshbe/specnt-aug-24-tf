provider "aws" {
  region     = "us-east-1"
  #profile = "aws-b1-d1"
  profile = "specnet-tf-aug-vms"
}

data "aws_instance" "webser" {
  filter {
    name   = "tag:Name"
    values = ["cust-web-server"]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }
}

data "aws_subnets" "subnet-ids" {
  filter {
    name   = "tag:Env"
    values = ["dev"]
  }
}

data "aws_vpc" "vpcname" {
  filter {
    name   = "tag:Name"
    values = ["vpc1-dev-c1"]
  }
}

resource "aws_ami_from_instance" "webserverami" {
  name               = "webserverami"
  source_instance_id = data.aws_instance.webser.id 
}

module "sgs" {
  source = "../modules/security-group"
  vpc-id = data.aws_vpc.vpcname.id
  security_groups = {
    web_sg_1 = {
      name    = "web-sg-1"
      ingress = [
        [80, 80, "tcp", ["0.0.0.0/0"]],
        [22, 22, "tcp", ["0.0.0.0/0"]]
      ]
      egress = [
        [0, 0, "-1", ["0.0.0.0/0"]]
      ]
    }
  }
}

module "LC01" {
  source = "../modules/launch-template"
  lc_name = "lc01"
  image_id = aws_ami_from_instance.webserverami.id
  key_name = "key1-aug-24"
  instance_type = "t2.micro"
  sg_ids = [module.sgs.sg_ids["web_sg_1"]]
}

module "ags01" {
  source = "../modules/autoscaling"
  ags_subnet_ids = data.aws_subnets.subnet-ids.ids 
  lc_id = module.LC01.lc-id
  #target_group_arns = 
}

output "instance_id" {
 value = data.aws_instance.webser.id 
}