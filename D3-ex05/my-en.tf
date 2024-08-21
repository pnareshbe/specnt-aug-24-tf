provider "aws" {
  region     = "us-east-1"
  profile = "aws-b1-d1"
}

module "mynet" {
    source = "../modules/vpc-subnet"
    vpc_cidr = "10.20.0.0/16" 
    vpc_name = "vpc1" 
    tag_env = "dev" 
    tag_dep = "finance"
    subnets = {
        sub1 = "10.20.4.0/24"
        sub2 = "10.20.5.0/24"
        sub3 = "10.20.6.0/24"
    }
}

module "myvolume" {
    source = "../modules/volumes"
    tag_env = "dev" 
    tag_dep = "finance"
    volume_name = "vol-dev"
    availability_zone = "us-east-1a"
    volume_size = "1"
}