provider "aws" {}

terraform {
  required_version = "~> 1.2.9"

}

module "ec2" {
  source = "./ec2"

  name                        = "ec2 by terraform"
  ami                         = data.aws_ami.img.id
  instance_type               = "t3.micro"
  subnet_id                   = ""
  vpc_id                      = ""
  associate_public_ip_address = true
  key_name                    = "key-pem"
  eip                         = "false"

  ingress = {
    "ingress_rule_1" = {
      "from_port"   = "80"
      "to_port"     = "80"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    "ingress_rule_2" = {
      "from_port"   = "22"
      "to_port"     = "22"
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  }

  enable_volume_tags = false
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      tags = {
        Name = "root-block"
      }
    },
  ]

  tags = { Environment = "hml" }
}

data "aws_ami" "img" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/*"]
  }
}