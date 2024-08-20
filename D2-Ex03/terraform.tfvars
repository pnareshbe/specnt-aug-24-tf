vpc_cidr = "10.20.0.0/16" 
vpc_name = "vpc1"  

tag_env = "dev" 
tag_dep = "finance"

#sub_cidr = "10.20.1.0/24" 
#sub_name = "sub1" 
sub_cidr = [ "10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24" ]
sub_name = [ "sub1", "sub2", "sub3" ]