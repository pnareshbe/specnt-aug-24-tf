# Provider region
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
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


# Tags for the resources
variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Env = "dev"
    Project = "customer-web-project"
  }
}
