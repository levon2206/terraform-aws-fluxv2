resource "aws_db_subnet_group" "rds_vpc_subnet_group" {
  description = "Created from Terraform"
  name        = var.rds_variables["subnet_group_name"]
  subnet_ids  = var.subnet-ids
}

