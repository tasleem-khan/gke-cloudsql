variable "project_id" {
  type        = string
  description = "The project ID to deploy to"
}

variable "region" {
  type        = string
  description = "The Compute Region to deploy to"
}

variable "zone" {
  type        = string
  description = "The Compute Zone to deploy to"
}

variable "nodes" {
  type        = string
  description = "The number of nodes in the managed instance group"
}

variable "deployment_name" {
  type        = string
  description = "The name of this particular deployment, will get added as a prefix to most resources."
  default     = "load-balanced-vms"
}

variable "labels" {
  type        = map(string)
  description = "A map of labels to apply to contained resources."
  default     = { "load-balanced-vms" = true }
}

variable "enable_apis" {
  type        = string
  description = "Whether or not to enable underlying apis in this solution. ."
  default     = true
}

variable "network_id" {
  type        = string
  description = "VPC network to deploy VMs in. A VPC will be created if not specified."
  default     = ""
}

variable "subnet_self_link" {
  type        = string
  description = "Subnetwork to deploy VMs in. A Subnetwork will be created if not specified."
  default     = ""
}

variable "network_project_id" {
  type        = string
  description = "Shared VPC host project ID if a Shared VPC is provided via network_id."
  default     = ""
}