data "aws_eks_cluster_auth" "cluster" {
  name = module.aws-eks.cluster_name
}