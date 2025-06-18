variable "subnets" {
  description = "Public subnets to attach to ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_group_id" {
  description = "Security group for ALB"
  type        = string
}
