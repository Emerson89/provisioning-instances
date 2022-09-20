resource "aws_db_instance" "db" {
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
  db_subnet_group_name         = var.db_subnet_group_name
  parameter_group_name         = var.parameter_group_name
  option_group_name            = var.option_group_name
  multi_az                     = var.multi_az
  vpc_security_group_ids       = var.vpc_security_group_ids
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

  tags = merge({ "Name" = var.identifier }, var.tags)
 
}