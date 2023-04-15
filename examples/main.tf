module "sg-ec2" {
  source = "git@github.com:Emerson89/terraform-modules.git//sg?ref=main"

  sgname      = "sgterraform"
  environment = "development"
  description = "Security group manager terraform"
  vpc_id      = ""

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

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 50
      tags = {
        Name = "root-block"
      }
    },
  ]
  tags = {
    Environment = "Development"
  }
}

