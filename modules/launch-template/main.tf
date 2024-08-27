resource "aws_launch_template" "foo" {
  name = var.lc_name

  /*block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }*/

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  disable_api_termination = true
  ebs_optimized = true
  image_id = var.image_id
  instance_type = var.instance_type

  key_name = var.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  #vpc_security_group_ids = var.sg_ids
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.sg_ids  # Security groups are defined here
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "LC01"
    }
  }
}