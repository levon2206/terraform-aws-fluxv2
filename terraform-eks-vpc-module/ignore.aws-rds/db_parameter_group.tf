resource "aws_db_parameter_group" "db_parameter_group" {
  description = "Created from Terraform"
  name        = var.rds_variables["db_parameter_group_name"]
  family      = var.parameter_group_family
    parameter {
    name  = "rds.logical_replication"
    value = "1"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_parameter_group" "db_parameter_group_replica" {
  description = "Created from Terraform"
  name        = var.rds_variables_replica["db_parameter_group_name"]
  family      = var.parameter_group_family
}
