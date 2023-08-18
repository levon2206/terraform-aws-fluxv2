# ########################################
# # tempo-payments-production reader Vars
# ########################################

resource "aws_db_instance" "rds-instance-replica" {
  count = var.enable_replica_instance ? 1 : 0
  #allocated_storage                     = var.rds_variables_replica["allocated_storage"]
  port                    = var.rds_variables_replica["port"]
  identifier              = var.rds_variables_replica["identifier"]
  instance_class          = var.rds_variables_replica["instance_class"]
  publicly_accessible     = var.rds_variables_replica["publicly_accessible"]
  availability_zone       = var.rds_variables_replica["availability_zone"]
  parameter_group_name    = aws_db_parameter_group.db_parameter_group_replica.name
  deletion_protection     = var.rds_variables_replica["deletion_protection"]
  backup_retention_period = var.rds_variables_replica["backup_retention_period"]
  option_group_name       = var.rds_variables_replica["option_group_name"]
  apply_immediately       = var.rds_variables_replica["apply_immediately"]
  #  db_subnet_group_name                  = aws_db_subnet_group.rds_vpc_subnet_group.name
  replicate_source_db                   = aws_db_instance.rds-instance.identifier
  vpc_security_group_ids                = [aws_security_group.rds_security_group.id]
  enabled_cloudwatch_logs_exports       = ["upgrade", "postgresql"]
  max_allocated_storage                 = var.rds_variables_replica["max_allocated_storage"]
  multi_az                              = var.rds_variables_replica["multi_az"]
  skip_final_snapshot                   = var.rds_variables_replica["skip_final_snapshot"]
  auto_minor_version_upgrade            = var.rds_variables_replica["auto_minor_version_upgrade"]
  iam_database_authentication_enabled   = var.rds_variables_replica["iam_database_authentication_enabled"]
  copy_tags_to_snapshot                 = var.rds_variables_replica["copy_tags_to_snapshot"]
  monitoring_interval                   = var.rds_variables_replica["monitoring_interval"]
  monitoring_role_arn                   = aws_iam_role.Monitoring-IAM-Role-RDS.arn
  performance_insights_enabled          = var.rds_variables_replica["performance_insights_enabled"]
  performance_insights_retention_period = var.rds_variables_replica["performance_insights_retention_period"]
  storage_encrypted                     = var.rds_variables_replica["storage_encrypted"]
  storage_type                          = var.rds_variables_replica["storage_type"]
}
