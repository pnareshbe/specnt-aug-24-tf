
## problem statement
if there are lost of variables , pasisng the value becomes a tough work and tracking also.
for example.

terraform plan -var vpc_cidr="10.20.0.0/16" -var vpc_name="vpc1" -var sub_cidr="10.20.1.0/24" -var sub_name="sub1" -var tag_env="dev" -var tag_dep="finance"

## solution:
use "terraform.tfvars"

define all the value in main.tf as variables, and define all the values in "terraform.tfvars"


Note:
Variable precedence
Highest to lowest 

CLI command using -var
terraform.tfvars
default value 

