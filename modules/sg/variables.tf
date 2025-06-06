variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "jenkins_sg_id" {
  description = "Security Group ID of Jenkins EC2 instance"
  type        = string
}
