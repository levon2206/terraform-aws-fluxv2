output "private-subnet-ids" {
  value = module.aws-vpc.private-subnet-ids
}

output "vpc-id" {
  value = module.aws-vpc.vpc-id
}

output "eks_cluster_name" {
  value = module.aws-eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.aws-eks.cluster_endpoint
}

output "eks_cluster_ca_certificate" {
  value = module.aws-eks.cluster_ca_certificate
}

output "identity-oidc-issuer" {
  value = module.aws-eks.identity-oidc-issuer
}
