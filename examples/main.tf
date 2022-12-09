module "ec2" {
  source = "../"

  instance_count              = var.instance_count
  name                        = var.name
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_id                      = var.vpc_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  eip                         = var.eip

  ingress = var.ingress

  enable_volume_tags = var.enable_volume_tags
  root_block_device  = var.root_block_device

  tags = var.tags
}