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

# this is for map of string 
variable "subnets" {
  type = map(string)
  # default = {
  #   sub1 = "10.20.1.0/24"
  #   sub2 = "10.20.2.0/24"
  # }
}
 