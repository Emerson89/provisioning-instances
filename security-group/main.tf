module "sg_ssh_terraform" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.18.0"

  name                = "sg_ssh_terraform"
  description         = "Security Group"
  vpc_id              = var.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Porta"
      cidr_blocks = "172.31.0.0/16"
    }
  ]
  egress_rules        = ["all-all"]
}