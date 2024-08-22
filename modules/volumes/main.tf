resource "aws_ebs_volume" "volume1" {
  #provider = aws.aws_dev
  availability_zone = var.availability_zone
  size              = var.volume_size

  tags = {
    Name = var.volume_name
    env = var.tag_env
    dep = var.tag_dep
  }
}