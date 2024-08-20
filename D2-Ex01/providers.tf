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

provider "aws" {
  alias = "aws_prod"
  region     = "us-east-2"
  profile = "aws-b1-d1-prod"
}

provider "azurerm" {
  features {
  }
}