output "sg_ids" {
  value = { for sg_name, sg in aws_security_group.web_sg : sg_name => sg.id }
}
