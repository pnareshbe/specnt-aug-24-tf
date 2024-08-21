vpc_cidr = "10.20.0.0/16" 
vpc_name = "vpc1" 
tag_env = "dev" 
tag_dep = "finance"

# this is for map of string 
subnets = {
     sub1 = "10.20.4.0/24"
     sub2 = "10.20.5.0/24"
     sub3 = "10.20.6.0/24"
}

enablevpc = true
enable_instance  = false
enable_lb = false
