provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

module "vpc" {
  //source  = "terraform-aws-modules/vpc/aws"
  //version = "3.14.0"
  source = "./modules/terraform-aws-vpc"
  name   = local.common_name
  cidr   = var.vpc_cdir_block

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets


  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false
  enable_vpn_gateway     = false
  reuse_nat_ips          = false


  tags = local.tags
  vpc_tags = {
    Name = local.common_name
  }
}

locals {
  common_name = "${var.namespace}-${var.env}-${var.env-index}"
  tags = {
    Project     = var.project
    Namespace   = var.namespace
    Environment = var.environment
    env         = var.env
    env-index   = var.env-index
  }
}
