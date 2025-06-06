output "asg_name" {
  value = aws_autoscaling_group.ecs_instances_asg.name
}
output "ami_id_used" {
  value = data.aws_ssm_parameter.ecs_ami.value
}
