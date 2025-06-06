output "jenkins_url" {
  value = "http://${module.jenkins_ec2.jenkins_public_ip}:8080"
}

output "alb_dns_name" {
  value = module.alb.alb_dns
}