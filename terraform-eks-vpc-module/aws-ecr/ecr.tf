#### AWS ECR Repo ####
resource "aws_ecr_repository" "simple-registry" {
  name                 = var.repo_names[count.index]
  count                = length(var.repo_names)
  image_tag_mutability = var.tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = {
    "Name" = "${var.general_tag}"
  }
}

#### ECR repo policy ####

resource "aws_ecr_repository_policy" "simple-registry-policy" {
  count      = length(var.repo_names)
  repository = aws_ecr_repository.simple-registry.*.name[count.index]
  policy     = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}


#### ECR Repo lifecycle policy ####

resource "aws_ecr_lifecycle_policy" "simple-registry-policy" {
  count      = length(var.repo_names)
  repository = aws_ecr_repository.simple-registry.*.name[count.index]
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 10
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
