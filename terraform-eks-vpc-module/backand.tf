terraform {
  required_version = ">= 1.0.0"
  # backend "http" {
  # }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

  }
}

provider "kubernetes" {
  host                   = module.aws-eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.aws-eks.cluster_ca_certificate)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
