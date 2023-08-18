variable "general_tag" {
  type = string
}

#### EKS cluster ####

variable "eks_vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(any)
}

variable "eks_version" {
  type = string
}

variable "addon_version" {
  type = string
}
variable "public_access_cidrs" {
  type = list(any)
}

#### node group ####


variable "node_desired_size" {
  type = string
}
variable "node_max_size" {
  type = string
}
variable "node_min_size" {
  type = string
}

variable "node_ami_type" {
  type = string
}
variable "node_capacity_type" {
  type = string
}

variable "node_disk_size" {
  type = string
}
variable "node_instance_types" {
  type = list
}
