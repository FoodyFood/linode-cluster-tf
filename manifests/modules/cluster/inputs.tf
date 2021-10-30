variable "enable_cluster" {
  description = "If false, cluster is removed or not created"
  type        = bool
}

variable "k8s_version" {
  description = "The Kubernetes version to use."
  type        = string
}

variable "label" {
  type = string
}

variable "region" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "pools" {
  description = "g6-standard-2 is a 2 CPU node, g6-standard-4 is a 4 CPU node and so on."
  type = list(object({
    type  = string
    count = number
  }))
}

variable "prefix" {
  description = "Prefix for linode infra"
  type        = string
}