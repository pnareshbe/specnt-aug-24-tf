# Provider region
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet CIDR blocks
variable "subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Availability Zones for subnets
variable "availability_zones" {
  description = "Availability zones for the subnets"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

# EC2 instance type
variable "instance_type" {
  description = "The instance type for the web server"
  type        = string
  default     = "t2.micro"
}

# Key pair name for the EC2 instance
variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

# Tags for the resources
variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Env = "dev"
    Project = "customer-web-project"
  }
}
