########################################
# RDS Vars
########################################

variable "enable_replica_instance" {
  type = bool
}
variable "rds_variables" {
  type = map(any)
}

variable "rds_variables_replica" {
  type = map(any)
}
variable "general_tag" {
  type = string
}

variable "security-group-vpc-id" {
  type = string
}

variable "subnet-ids" {
  type = list(any)
}


variable "parameter_group_family" {
  type = string
}


variable "ip_addresses" {
  description = "Ingress IP CIDR blocks and their descriptions"
  type        = map(any)
}
