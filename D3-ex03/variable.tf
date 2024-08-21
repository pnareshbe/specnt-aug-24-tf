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

variable "availability_zone" {}
variable "volume_size" {}
variable "volume_name" {}