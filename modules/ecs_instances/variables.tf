

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "cluster_name" {
  description = "Name of ECS Cluster to register with"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the EC2 instances"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups for the ECS instances"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 2
}

variable "instance_profile" {
  description = "IAM instance profile for ECS EC2 instance"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}



