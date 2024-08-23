resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name = var.key_name
  associate_public_ip_address = var.enable_pub_ip
  
  vpc_security_group_ids = var.sg_ids

   #user_data = file("${path.module}/userdata.sh")
   user_data = file("${var.filepath}")
   


  tags = merge(var.tags, { Name = "cust-web-server" })
}

resource "aws_ebs_volume" "volume1" {
  count = var.new_volume ? 1 : 0
  #provider = aws.aws_dev
  availability_zone = aws_instance.web_server.availability_zone
  size              = var.volume_size

  tags = {
    Name = var.volume_name
    env = var.tag_env
    dep = var.tag_dep
  }
}

resource "aws_volume_attachment" "example" {
  device_name = var.device_name  # Device name on the instance
  volume_id   = aws_ebs_volume.volume1[0].id
  instance_id = aws_instance.web_server.id
}


