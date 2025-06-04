provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "jenkins_ec2" {
  source   = "./modules/jenkins_ec2"
  vpc_id   = module.vpc.vpc_id
  subnets  = module.vpc.public_subnets
  key_name = var.key_name
}

module "alb" {
  source             = "./modules/alb"
  subnets            = module.vpc.public_subnets
  vpc_id             = module.vpc.vpc_id
  security_group_id  = module.jenkins_ec2.jenkins_sg_id
}

module "ecs" {
  source             = "./modules/ecs"
  cluster_name       = "hello-world-cluster"
  image_url          = "public.ecr.aws/your-alias/hello-world-app:latest"
  execution_role_arn = module.iam.execution_role_arn
  target_group_arn   = module.alb.target_group_arn
  lb_listener        = module.alb.lb_listener
}
