output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins_sg.id
}
