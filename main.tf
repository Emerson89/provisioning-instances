provider "aws" {
  region  = var.region
  profile = var.profile
}

terraform {
  required_version = "~> 1.0.0"
}

module "ec2" {
  source = "./ec2"

  name                        = var.name
  #ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  cpu_credits                 = var.cpu_credits
  instance_count              = var.instance_count
  associate_public_ip_address = var.associate_public_ip_address
  ingress_ports               = var.ingress_ports
  egress_ports                = var.egress_ports

  vpc_id         = var.vpc_id
  subnet_id      = var.subnet_id
  vpc_cidr_block = var.vpc_cidr_block

  ebs_block_device = [{
    device_name = var.dev
    volume_type = var.type
    volume_size = var.ebs_size
  }]

  tags = {
    Environment = "ec2 by terraform"
  }
}
