module "ec2" {
  source = "../../ec2"

  name                        = var.name
  owner                       = var.owner
  values                      = var.values
  vpc_security_group_ids      = [module.sg-ec2.sg_id]
  instance_type               = var.instance_type
  subnet_id                   = "subnet-0785a797e13xxxx905"
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  eip                         = var.eip

  root_block_device = var.root_block_device

  tags = var.tags
}

module "sg-ec2" {
  source = "git@github.com:Emerson89.git//modules-terraform//sg"

  sgname      = var.sgname_ec2
  environment = var.environment
  description = var.description
  vpc_id      = "vpc-0eefb03830cxxx"

  tags = var.tags

  ingress_with_cidr_blocks = var.ingress_ec2
}