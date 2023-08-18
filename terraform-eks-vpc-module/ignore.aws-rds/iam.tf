# IAM Role for RDS Enhanced Monitoring
resource "aws_iam_role" "Monitoring-IAM-Role-RDS" {

  name = "Monitoring-IAM-Role-RDS"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]

  tags = {
    Name = "${var.general_tag}"
  }
}
