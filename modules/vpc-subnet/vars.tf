variable "tag_env" {
  description = "This is env tag"
  validation {
    condition = var.tag_env == "dev" || var.tag_env == "test" || var.tag_env == "test"
    error_message = "The values do not match with dev or test or prod"
  }
}
variable "tag_dep" {
  default = "admin"
}
variable "vpc_cidr" {}
variable "vpc_name" {}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  }

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Env = "dev"
    Project = "customer-web-project"
  }
}

variable "enable_ig" {}