terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "../../modules/vpc"
  env_name = "dev"
  vpc_cidr = "10.0.0.0/16"
  subnet1_cidr_block = "10.0.0.0/24"
  subnet2_cidr_block = "10.0.1.0/24"
}

module "ec2" {
  source = "../../modules/ec2"
  subnet_id = module.vpc.subnet1_id
  ami = "ami-005de95e8ff495156"
  env_name = "dev"
  instance_type = "t2.nano"
}

module "db_mysql" {
  source = "../../modules/db"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  env_name             = "dev"
  instance_class       = "db.t2.micro"
  username             = "acs"
  password             = "acscorporg"
  parameter_group_name = "default.mysql5.7"
}

module "sg" {
 source = "../../modules/sg"
 env_name    = "dev"
 vpc_id      = module.vpc.vpc_id
 cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
}

module "gateway" {
 source = "../../modules/gateway"
 env_name    = "dev"
 vpc_id      = module.vpc.vpc_id
}

module "alb" {
 source = "../../modules/loadbalancer"
 env_name    = "dev"
 subnet_ids  = [module.vpc.subnet1_id, module.vpc.subnet2_id]
 sg_id = [module.sg.sg_id]
}
