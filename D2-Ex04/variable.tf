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


/*variable "sub_cidr" {
  type = list(string)
  #default = [ "10.20.1.0/24", "10.20.2.0/24" ]
}
variable "sub_name" {
  type = list(string)
  #default = [ "sub1", "sub2" ]
}*/

# this is for map of string 
variable "subnets" {
  type = map(string)
  # default = {
  #   sub1 = "10.20.1.0/24"
  #   sub2 = "10.20.2.0/24"
  # }
}

# this is for map of objects 
variable "subnets1" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    name              = string
  }))
  }