provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Environment = "Stage"
      Project     = "simple-app"
    }
  }
}

# module "aws-rds" {
#   source                  = "./aws-rds"
#   rds_variables           = var.rds_variables
#   rds_variables_replica   = var.rds_variables_replica
#   general_tag             = var.general_tag
#   ip_addresses            = var.ip_addresses
#   parameter_group_family  = var.parameter_group_family
#   enable_replica_instance = var.enable_replica_instance
#   security-group-vpc-id   = module.aws-vpc.vpc-id
#   subnet-ids              = module.aws-vpc.private-subnet-ids
# }

module "aws-vpc" {
  source               = "./aws-vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
  general_tag          = var.general_tag
}

module "aws-eks" {
  source              = "./aws-eks"
  eks_vpc_id          = module.aws-vpc.vpc-id
  private_subnet_ids  = module.aws-vpc.private-subnet-ids
  general_tag         = var.general_tag
  eks_version         = var.eks_version
  addon_version       = var.eks_addon_version
  public_access_cidrs = var.eks_public_access_cidrs
  node_desired_size   = var.node_desired_size
  node_max_size       = var.node_max_size
  node_min_size       = var.node_min_size
  node_ami_type       = var.node_ami_type
  node_capacity_type  = var.node_capacity_type
  node_disk_size      = var.node_disk_size
  node_instance_types = var.node_instance_types

}

module "ebs_csi_driver_controller" {
  source  = "DrFaust92/ebs-csi-driver/kubernetes"
  version = "3.9.0"

  ebs_csi_controller_image                   = "registry.k8s.io/provider-aws/aws-ebs-csi-driver"
  ebs_csi_driver_version                     = "v1.21.0"
  ebs_csi_controller_role_name               = "ebs-csi-driver-controller"
  ebs_csi_controller_role_policy_name_prefix = "ebs-csi-driver-policy"
  oidc_url                                   = module.aws-eks.identity-oidc-issuer
}

module "aws-ecr" {
  source         = "./aws-ecr"
  repo_names     = var.ecr_repo_names
  tag_mutability = var.ecr_tag_mutability
  scan_on_push   = var.ecr_scan_on_push
  general_tag    = var.general_tag
}
