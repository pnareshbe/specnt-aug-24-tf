variable "instance_type" {}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Env = "dev"
    Project = "customer-web-project"
  }
}

variable "key_name" {}

variable "sg_ids" {
  type = list 
}

variable "subnet_id" {}

variable "ami_id" {}

variable "enable_pub_ip" {}

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

# Variables for Volumes 
variable "volume_size" {
  default = "4"
}
variable "volume_name" {
  default = "vol1"
}

variable "new_volume" {
  default = false
}

variable "device_name" {
  default = "/dev/sdf"
}

variable "filepath" {
  
}