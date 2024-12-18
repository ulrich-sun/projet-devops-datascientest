data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-jammy-22.04-amd64-minimal-*"]
  }
}

module "docker" {
  source           = "./modules/docker"
  ami              = data.aws_ami.ubuntu.id
  instance_type    = var.instance_type
  sg_id            = module.security_group.security_group_name
  key_name         = local.key_name
  vm_name          = local.vm_name
  private_key_path = local.filename
  depends_on = [ module.keypair ]
  count = var.stack == "docker" ? 1 : 0
}
module "k3s" {
  source           = "./modules/k3s"
  ami              = data.aws_ami.ubuntu.id
  instance_type    = var.instance_type
  sg_id            = module.security_group.security_group_name
  key_name         = local.key_name
  vm_name          = local.vm_name
  private_key_path = local.filename
  depends_on = [ module.keypair ]
  count = var.stack == "k3s" ? 1 : 0
}

locals {
  filename = "./keypair/${var.stack}.pem"
  vm_name  = var.stack
  key_name = var.stack

}
module "keypair" {
  source   = "./modules/keypair"
  filename = local.filename
  key_name = local.key_name
}

module "security_group" {
  source  = "./modules/security_group"
  sg_name = var.sg_name
}
