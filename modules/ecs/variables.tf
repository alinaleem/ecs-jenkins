variable "cluster_name" {
  description = "ECS Cluster name"
  type        = string
}

variable "image_url" {
  description = "Docker image URL"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role for ECS task execution"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "lb_listener" {
  description = "ALB listener dependency"
}
