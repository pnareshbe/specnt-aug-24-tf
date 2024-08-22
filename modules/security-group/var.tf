variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Env = "dev"
    Project = "customer-web-project"
  }
}

/*variable "security_groups" {
  description = "Map of security group configurations"
  type = map(object({
    name    = string
    ingress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    egress = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
  }))
}*/

/*variable "security_groups" {
  description = "Map of security group configurations"
  type = map(object({
    name    = string
    ingress = list(list(any))  # Change to list of lists
    egress  = list(list(any))  # Change to list of lists
  }))
}*/

variable "security_groups" {
  type    = map(any)
  default = {}
  /* web_sg_1 = {
      name    = "web-sg-1"
      ingress = [
        [80, 80, "tcp", ["0.0.0.0/0"]],
        [22, 22, "tcp", ["0.0.0.0/0"]]
      ]
      egress = [
        [0, 0, "-1", ["0.0.0.0/0"]]
      ]
    }*/
}

variable "vpc-id" {}

