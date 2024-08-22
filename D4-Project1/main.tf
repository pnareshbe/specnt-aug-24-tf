# Provider configuration
provider "aws" {
  region = var.region
  profile = "specnet-tf-aug"
}

# VPC
resource "aws_vpc" "customer_vpc" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, { Name = "customer-vpc" })
}

# Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.customer_vpc.id
  cidr_block              = var.subnet_cidrs[0]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[0]
  tags = merge(var.tags, { Name = "public-subnet-1" })
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.customer_vpc.id
  cidr_block              = var.subnet_cidrs[1]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[1]
  tags = merge(var.tags, { Name = "public-subnet-2" })
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.customer_vpc.id
  cidr_block              = var.subnet_cidrs[2]
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[2]
  tags = merge(var.tags, { Name = "public-subnet-3" })
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.customer_vpc.id
  tags = merge(var.tags, { Name = "customer-igw" })
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.customer_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.tags, { Name = "public-route-table" })
}

# Associate the route table with the first subnet
resource "aws_route_table_association" "public_rt_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.customer_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags, { Name = "web-sg" })
}

# Generate an SSH key pair
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "generated_key" {
  key_name   = "my-key-pair" # You can customize this name
  public_key = tls_private_key.example_key.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.example_key.private_key_pem
  filename = "${path.module}/my-key-pair.pem"
}


# EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-066784287e358dad1" # Amazon Linux 3 AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = aws_key_pair.generated_key.key_name

  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  

  tags = merge(var.tags, { Name = "customer-web-server" })
}

# Output the public IP of the web server
output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
