variable "iam_instance_profile" {
  description = "IAM instance profile to attach to EC2"
  type        = string
  default     = null
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}