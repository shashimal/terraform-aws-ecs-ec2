locals {
  cluster_name = "ecs-ec2"

  service_map = {
    nginx = {
      is_public     = true
      name          = "nginx"
      image         = "nginx"
      cpu           = 10
      memory        = 512
      containerPort = 80
      hostPort      = 80
      essential     = true
    }
#    httpd = {
#      is_public     = true
#      name          = "httpd"
#      image         = "httpd"
#      cpu           = 10
#      memory        = 512
#      containerPort = 80
#      hostPort      = 80
#      essential     = true
#    }
  }
}
module "ecs" {
  source = "../"

  cluster_name    = local.cluster_name
  service_map     = local.service_map
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "ecs-vpc"
  cidr = "20.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["20.0.1.0/24", "20.0.2.0/24", "20.0.3.0/24"]
  public_subnets  = ["20.0.101.0/24", "20.0.102.0/24", "20.0.103.0/24"]

  enable_nat_gateway = false
}
