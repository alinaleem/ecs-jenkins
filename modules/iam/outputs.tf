output "jenkins_instance_profile_name" {
  value = aws_iam_instance_profile.jenkins_instance_profile.name
}

output "execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "jenkins_role_arn" {
  value = aws_iam_role.jenkins_ec2_role.arn
}
