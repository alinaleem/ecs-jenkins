provider "aws" {
  region = var.region
}

# ---------------------------
# VPC Module
# ---------------------------
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
}

# ---------------------------
# IAM Module (Jenkins & ECS)
# ---------------------------
module "iam" {
  source = "./modules/iam"
}

# ---------------------------
# Jenkins EC2 Instance
# ---------------------------
module "jenkins_ec2" {
  source               = "./modules/jenkins_ec2"
  vpc_id               = module.vpc.vpc_id
  subnets              = module.vpc.public_subnets
  iam_instance_profile = module.iam.jenkins_instance_profile_name
  key_name             = var.key_name
}

# ---------------------------
# Security Groups
# ---------------------------
module "sg" {
  source        = "./modules/sg"
  vpc_id        = module.vpc.vpc_id
  jenkins_sg_id = module.jenkins_ec2.jenkins_sg_id
}

# ---------------------------
# Application Load Balancer
# ---------------------------
module "alb" {
  source            = "./modules/alb"
  subnets           = module.vpc.public_subnets
  vpc_id            = module.vpc.vpc_id
  security_group_id = module.jenkins_ec2.jenkins_sg_id
}

# ---------------------------
# ECR Repository
# ---------------------------
module "ecr" {
  source           = "./modules/ecr"
  repo_name        = "hello-world-app"
  jenkins_role_arn = module.iam.jenkins_role_arn
}

# ---------------------------
# ECS Cluster, Task & Service
# ---------------------------
module "ecs" {
  source             = "./modules/ecs"
  cluster_name       = "hello-world-cluster"
  image_url          = "${var.account_id}.dkr.ecr.${var.region}.amazonaws.com/hello-world-app:latest"
  execution_role_arn = module.iam.execution_role_arn
  target_group_arn   = module.alb.target_group_arn
  lb_listener        = module.alb.lb_listener
}

# ---------------------------
# ECS EC2 Instances
# ---------------------------
module "ecs_instances" {
  source             = "./modules/ecs_instances"
  instance_type      = "t3.micro"
  key_name           = var.key_name
  cluster_name       = module.ecs.cluster_id
  subnet_ids         = module.vpc.private_subnets
  security_group_ids = [module.sg.ecs_sg_id]
  desired_capacity   = 2
  min_size           = 1
  max_size           = 3
  instance_profile   = module.iam.ecs_instance_profile_name
}
