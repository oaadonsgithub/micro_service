# main.tf
provider "aws" {
  region = var.region
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = var.vpc_id
}

module "launch_template" {
  source         = "./modules/launch_template"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  key_name       = var.key_name
  security_group = module.security_group.web_sg_id
}

module "iam" {
  source         = "./modules/iam"
  region         = var.region
  aws_account_id = var.aws_account_id
}

module "autoscaling" {
  source          = "./modules/autoscaling"
  subnet_ids      = var.subnet_ids
  launch_template = module.launch_template.launch_template_id
}

module "alb" {
  source        = "./modules/alb"
  subnet_ids    = var.subnet_ids
  vpc_id        = var.vpc_id
  sg_id         = module.security_group.web_sg_id
  certificate_arn = var.certificate_arn
  active_color  = var.active_color
}

module "ecs" {
  source         = "./modules/ecs"
  region         = var.region
  aws_account_id = var.aws_account_id
  tg_blue        = module.alb.tg_blue
  tg_green       = module.alb.tg_green
}

module "codedeploy" {
  source           = "./modules/codedeploy"
  region           = var.region
  aws_account_id   = var.aws_account_id
  tg_blue          = module.alb.tg_blue
  tg_green         = module.alb.tg_green
  listener_443     = module.alb.listener_443
  listener_8080    = module.alb.listener_8080
  ecs_cluster      = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  web_task_role_arn = module.iam.web_task_role_arn
}