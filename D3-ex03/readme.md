## problem
* 1. how to create similar resource for multiple environments

## partial solution
* 1. create multiple resource for diff env in the manifest file
* 2. create multiple folder with "main.tf, variables.tf, providers.tf, terraform.tfvars"

--> issue
repeated codes, multiple lines of codes to maintain

## Solution
* 1. using workspace
