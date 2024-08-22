
provider "aws" {
  region     = "us-east-1"
  #profile = "aws-b1-d1"
  profile = "specnet-tf-aug"
}

/*terraform {
 backend "s3" {
   bucket = "vishwa21082024"
   #bucket = "vishwa2108202401"
   region = "us-east-1"
   key = "terraform-mod1.tfstate"
 }
}*/


module "mynet" {
    source = "../modules/vpc-subnet"
    enable_ig = true # Enabling this, will create IGW, New route table, associate the subnet to RT
    vpc_cidr = "10.10.0.0/16"
    vpc_name = "vpc1" 
    tag_env = "dev" 
    tag_dep = "finance"
    public_subnets = {
    sub1 = {
        cidr_block        = "10.10.1.0/24"
        availability_zone = "us-east-1a"
        name              = "sub1"
      },
        sub2 = {
        cidr_block        = "10.10.2.0/24"
        availability_zone = "us-east-1b"
        name              = "sub2"
      }
        sub3 = {
        cidr_block        = "10.10.3.0/24"
        availability_zone = "us-east-1c"
        name              = "sub3"
      }
    }
}

module "new-key-pair" {
  source = "../modules/key-pair"
  key_name1 = "key1-aug-24"
}

module "sgs" {
  source = "../modules/security-group"
  vpc-id = module.mynet.vpc-id
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
/*
# EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-066784287e358dad1" # Amazon Linux 3 AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnets["sub1"].id
  key_name      = aws_key_pair.generated_key.key_name

  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  

  tags = merge(var.tags, { Name = "customer-web-server" })
}

# Output the public IP of the web server
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}*/
