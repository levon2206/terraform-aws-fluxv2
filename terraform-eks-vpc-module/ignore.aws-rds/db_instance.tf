# ########################################
# # tempo-payments-production writer Vars
# ########################################

resource "aws_db_instance" "rds-instance" {
  allocated_storage                     = var.rds_variables["allocated_storage"]
  username                              = var.rds_variables["username"]
  password                              = var.rds_variables["password"]
  port                                  = var.rds_variables["port"]
  engine                                = var.rds_variables["engine"]
  engine_version                        = var.rds_variables["engine_version"]
  identifier                            = var.rds_variables["identifier"]
  instance_class                        = var.rds_variables["instance_class"]
  publicly_accessible                   = var.rds_variables["publicly_accessible"]
  availability_zone                     = var.rds_variables["availability_zone"]
  deletion_protection                   = var.rds_variables["deletion_protection"]
  backup_retention_period               = var.rds_variables["backup_retention_period"]
  option_group_name                     = var.rds_variables["option_group_name"]
  apply_immediately                     = var.rds_variables["apply_immediately"]
  multi_az                              = var.rds_variables["multi_az"]
  max_allocated_storage                 = var.rds_variables["max_allocated_storage"]
  vpc_security_group_ids                = [aws_security_group.rds_security_group.id]
  monitoring_role_arn                   = aws_iam_role.Monitoring-IAM-Role-RDS.arn
  db_subnet_group_name                  = aws_db_subnet_group.rds_vpc_subnet_group.name
  parameter_group_name                  = aws_db_parameter_group.db_parameter_group.name
  skip_final_snapshot                   = var.rds_variables["skip_final_snapshot"]
  auto_minor_version_upgrade            = var.rds_variables["auto_minor_version_upgrade"]
  iam_database_authentication_enabled   = var.rds_variables["iam_database_authentication_enabled"]
  copy_tags_to_snapshot                 = var.rds_variables["copy_tags_to_snapshot"]
  monitoring_interval                   = var.rds_variables["monitoring_interval"]
  performance_insights_enabled          = var.rds_variables["performance_insights_enabled"]
  performance_insights_retention_period = var.rds_variables["performance_insights_retention_period"]
  storage_encrypted                     = var.rds_variables["storage_encrypted"]
  storage_type                          = var.rds_variables["storage_type"]
  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]
}
