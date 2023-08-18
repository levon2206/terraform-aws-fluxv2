variable "repo_names" {
  type    = list(string)
}

variable "general_tag" {
  type = string
}

variable "tag_mutability" {
  type    = string
}

variable "scan_on_push" {
  type    = string
}
