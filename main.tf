provider "aws" {
	region = var.region
	profile = var.profile
}

terraform {
  required_version = "~> 1.0.0"
  }

module "ec2" {
  source = "./ec2"
  
  name = "var.name"
  ami = "var.ami"
  instance_type = "var.instance_type"
  key_name = "var.key_name"
  security_groups = var.security_groups

  ebs_block_device = [{
	device_name         = "/dev/sda1"
    volume_type         = "gp2"
    volume_size         = var.ebs_size
  }]

  tags = {
    Environment = "var.tags"
  }
}

module "security-group" {
	source = "./security-group"

    vpc_id = "var.vpc_id"  
    vpc_cidr_block = "var.vpc_cidr_block"

}