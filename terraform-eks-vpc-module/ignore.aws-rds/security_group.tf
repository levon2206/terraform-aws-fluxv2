########################################
# RDS Vars
########################################locals {
locals {
  ip_addresses = var.ip_addresses
}
resource "aws_security_group" "rds_security_group" {
  description = "k8s cluster wide security for VPC CIDR only access"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    protocol    = "-1"
    self        = "false"
    to_port     = "0"
  }

  dynamic "ingress" {
    for_each = local.ip_addresses
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.general_tag}"
  }
  name   = var.general_tag
  vpc_id = var.security-group-vpc-id
}
