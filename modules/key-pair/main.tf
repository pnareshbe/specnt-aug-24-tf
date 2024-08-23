# Generate an SSH key pair
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS Key Pair using the generated public key
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name1 # You can customize this name
  public_key = tls_private_key.example_key.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.example_key.private_key_pem
  filename = "${var.path}/${var.key_name1}.pem"
}


output "key_path" {
  value = "${var.path}/${var.key_name1}.pem"
}