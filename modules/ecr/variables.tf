variable "repo_name" {
  description = "ECR repository name"
  type        = string
}

variable "jenkins_role_arn" {
  description = "ARN of the Jenkins EC2 IAM Role"
  type        = string
}
