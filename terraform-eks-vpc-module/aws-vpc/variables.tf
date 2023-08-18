variable "vpc_cidr" {
  type = string
}

variable "public_subnets_cidr" {
  type = list(any)
}

variable "private_subnets_cidr" {
  type = list(any)
}

variable "availability_zones" {
  type = list(any)
}

variable "general_tag" {
  type = string
}
