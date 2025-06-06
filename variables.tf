variable "key_name" {
  description = "EC2 key pair name for SSH access"
  type        = string
}
variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_url" {
  type        = string
  description = "Full ECR image URL for the container"
}

variable "account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "region" {
  type        = string
  description = "AWS Region"
}
