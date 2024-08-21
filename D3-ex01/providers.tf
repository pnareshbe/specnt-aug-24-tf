terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
  alias = "aws_dev"
  region     = "us-east-1"
  profile = "aws-b1-d1"
}

