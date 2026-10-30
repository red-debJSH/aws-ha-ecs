module "vpc" {
  source = "../../modules/vpc"

  name     = "josue-app"
  vpc_cidr = "10.0.0.0/16"

  public_subnets = {
    a = {
      cidr = "10.0.1.0/24"
      az   = "us-east-2a"
    }
    b = {
      cidr = "10.0.2.0/24"
      az   = "us-east-2b"
    }
  }

  private_subnets = {
    a = {
      cidr = "10.0.3.0/24"
      az   = "us-east-2a"
    }
    b = {
      cidr = "10.0.4.0/24"
      az   = "us-east-2b"
    }
  }
}

module "ecr" {
  source = "../../modules/ecr"

  name = "josue-app-front"
}

module "ecr-back" {
  source = "../../modules/ecr"

  name = "josue-app-back"
}

module "ecs" {
  source = "../../modules/ecs"

  name   = "josue-app"
  vpc_id = module.vpc.vpc_id

  front = "josue-app-front"
  back  = "josue-app-back"
}

module "rds" {
  source          = "../../modules/rds"
  name            = "josueapp"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnet_ids
  username        = "admin"
  sg_name         = "josue-app-db"
  backend_sg_id   = module.ecs.back_security_group_id
}