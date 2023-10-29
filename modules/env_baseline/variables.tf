
variable "env" {
  description = "The environment to prepare (ex. development)"
  type        = string
}

variable "project_id" {
  description = "project Id in which resources to be created"
  type        = string
}


variable "remote_state_bucket" {
  description = "Backend bucket to load Terraform Remote State Data from previous steps."
  type        = string
}


variable "default_network_tier" {
  description = "Default Network Service Tier for resources created in this project. If unset, the value will not be modified. See https://cloud.google.com/network-tiers/docs/using-network-service-tiers and https://cloud.google.com/network-tiers."
  type        = string
  default     = ""
}

variable "subnets" {
  description = "List of subnet configurations"
  type        = list(object({
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    subnet_private_access = bool
    subnet_flow_logs      = bool
    secondary_ranges      = map(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
  default     = []
}