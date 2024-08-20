vpc_cidr = "10.20.0.0/16" 
vpc_name = "vpc1"  

tag_env = "dev" 
tag_dep = "finance"

#sub_cidr = "10.20.1.0/24" 
#sub_name = "sub1" 

#sub_cidr = [ "10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24" ]
#sub_name = [ "sub1", "sub2", "sub3" ]

# this is for map of string 
subnets = {
     sub1 = "10.20.1.0/24"
     sub2 = "10.20.2.0/24"
     sub3 = "10.20.3.0/24"
}

# this is for map of objects 
subnets1 =  {
    sub1 = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-west-2a"
        name              = "dev-subnet-1"
      }
    sub2 = {
        cidr_block        = "10.0.1.0/24"
        availability_zone = "us-west-2a"
        name              = "dev-subnet-1"
      }
}