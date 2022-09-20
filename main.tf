provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

terraform {
  required_version = "~> 1.0.0"

  backend "s3" {
    bucket  = "s3-tfstates-terraform"
    key     = "terraform-ec2.tfstate"
    region  = "us-east-1"
    profile = "CUSTOM-PROFILE"
  }
}

module "ec2" {
  source = "./ec2"

  name                        = var.name
  ami                         = data.aws_ami.wordpress.id
  instance_type               = var.instance_type
  subnet_id                   = element(module.vpc.public_subnets, 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  enable_volume_tags = false
  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 50
      tags = {
        Name = "root-block-wp"
      }
    },
  ]

  tags = { Environment = "hml" }
}

data "aws_ami" "wordpress" {
  most_recent = true
  owners      = ["MY-ACCOUNT"]

  filter {
    name   = "name"
    values = ["wp-*"]
  }
}

module "db" {
  source = "./rds"

  identifier                   = var.identifier
  allocated_storage            = var.allocated_storage
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  storage_type                 = var.storage_type
  storage_encrypted            = var.storage_encrypted
  db_name                      = var.db_name
  username                     = var.username
  password                     = var.password
  db_subnet_group_name         = module.vpc.database_subnet_group_name
  parameter_group_name         = var.parameter_group_name
  option_group_name            = var.option_group_name
  multi_az                     = var.multi_az
  vpc_security_group_ids       = [module.security_group_db.security_group_id]
  publicly_accessible          = var.publicly_accessible
  performance_insights_enabled = var.performance_insights_enabled
  deletion_protection          = var.deletion_protection
  snapshot_identifier          = var.snapshot_identifier

  skip_final_snapshot = var.skip_final_snapshot

  maintenance_window          = var.maintenance_window
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  allow_major_version_upgrade = var.allow_major_version_upgrade
  backup_window               = var.backup_window
  backup_retention_period     = var.backup_retention_period
  apply_immediately           = var.apply_immediately
  tags                        = { Environment = "hml" }

}