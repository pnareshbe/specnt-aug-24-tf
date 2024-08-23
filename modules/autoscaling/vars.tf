variable "ags_subnet_ids" {
  type = list 
}
variable "lc_id" {
  
}

variable "tags" {
  description = "A map of tags to apply to all resources"
  type        = map(string)
  default = {
    Env = "dev"
    Project = "customer-web-project"
  }
}

variable "target_group_arns" {
  default = ""
}