region            = "us-east-1"
vpc_cidr          = "10.10.0.0/16"
subnet_cidrs      = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
instance_type     = "t2.micro"
key_name          = "my-key-pair"

tags = {
  Env     = "dev"
  Project = "customer-web-project"
}
