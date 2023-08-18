# resource "aws_eks_addon" "ebs-csi-driver" {
#   cluster_name  = aws_eks_cluster.eks_cluster.name
#   addon_name    = "aws-ebs-csi-driver"
#   addon_version = var.addon_version
# }