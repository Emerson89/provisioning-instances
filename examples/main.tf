module "sg-ec2" {
  source = "git@github.com:Emerson89/terraform-modules.git//sg?ref=main"

  sgname      = "sgterraform"
  environment = "development"
  description = "Security group manager terraform"
  vpc_id      = "vpc-abcabcdabc1234"

  tags = {
    Environment = "Development"
  }

  ingress_with_cidr_blocks = local.ingress_ec2
}

## EC2
module "ec2" {
  source = "github.com/Emerson89/provisioning-instances.git//?ref=master"

  name                        = "ec2-terraform"
  vpc_security_group_ids      = [module.sg-ec2.sg_id]
  instance_type               = "t3.micro"
  associate_public_ip_address = false
  key_name                    = "key"
  eip                         = false
  subnet_id                   = "subnet-0397a0a1714227ce6"
  image_name                  = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
  owner                       = "099720109477"

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 10
      #delete_on_termination = false
      tags = {
        Name = "root-block"
      }
    },
  ]
  tags = {
    Environment = "Development"
  }
}

