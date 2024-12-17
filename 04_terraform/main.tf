data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-jammy-22.04-amd64-minimal-*"]
  }
}

module "ec2" {
  source           = "./modules/ec2"
  ami              = data.aws_ami.ubuntu.id
  instance_type    = var.instance_type
  sg_id            = module.vpc.vpc_id
  key_name         = var.key_name
  subnet_id        = module.vpc.subnet_id
  vm_name          = var.vm_name
  private_key_path = local.filename
}

module "eip" {
  source   = "./modules/eip"
  eip_name = var.eip_name
}

locals {
  filename = "./keypair/${var.key_name}.pem"
}
module "keypair" {
  source   = "./modules/keypair"
  filename = local.filename
  key_name = var.key_name
}

module "security_group" {
  source  = "./modules/security_group"
  sg_name = var.sg_name
  vpc_id  = module.vpc.vpc_id
}

module "vpc" {
  source      = "./modules/vpc"
  rt_name     = var.rt_name
  igw_name    = var.igw_name
  vpc_name    = var.vpc_name
  subnet_name = var.subnet_name
}