#### General Variables ####
variable "general_tag" {
  type    = string
  default = "simple-app"
}

#### VPC Variables ####

variable "vpc_cidr" {
  type    = string
  default = "177.31.0.0/16"
}

variable "public_subnets_cidr" {
  type    = list(any)
  default = ["177.31.32.0/20", "177.31.16.0/20", "177.31.0.0/20"]
}

variable "private_subnets_cidr" {
  type    = list(any)
  default = ["177.31.48.0/20", "177.31.64.0/20", "177.31.80.0/20"]
}


variable "availability_zones" {
  type    = list(any)
  default = ["eu-central-1c", "eu-central-1b", "eu-central-1a", ]
}

#### EKS Variables ####
variable "eks_version" {
  type    = string
  default = "1.27"
}

variable "eks_addon_version" {
  type    = string
  default = "v1.21.0-eksbuild.1"
}

variable "eks_public_access_cidrs" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

#### EkS node group ####

variable "node_desired_size" {
  type    = string
  default = "3"
}
variable "node_max_size" {
  type    = string
  default = "3"
}
variable "node_min_size" {
  type    = string
  default = "3"
}

variable "node_ami_type" {
  type    = string
  default = "AL2_x86_64"
}

variable "node_capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "node_disk_size" {
  type    = string
  default = "30"
}
variable "node_instance_types" {
  type    = list(any)
  default = ["t3.small"]
}

#### ECR Variables ####

variable "ecr_repo_names" {
  type    = list(string)
  default = ["simple-app"]
}

variable "ecr_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "ecr_scan_on_push" {
  type    = string
  default = false
}

