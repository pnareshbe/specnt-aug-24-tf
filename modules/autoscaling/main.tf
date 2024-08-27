# Step 3: Create an Auto Scaling Group
resource "aws_autoscaling_group" "example" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.ags_subnet_ids  # Replace with your subnet IDs

  launch_template {
    id      = var.lc_id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 100

  #tags = merge(var.tags, { Name = each.value.name })

  #target_group_arns = var.target_group_arns # Attach to a load balancer target group if needed

  lifecycle {
    create_before_destroy = true
  }
}