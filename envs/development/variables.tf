variable "remote_state_bucket" {
  description = "Backend bucket to load Terraform Remote State Data from previous steps."
  type        = string
}

variable "org_id" {
  description = "Organization ID"
  type        = string
}


variable "billing_account" {
  description = "Billing Account ID"
  type        = string
}

variable "environment" {
  description = "Decsribes Environment Type"
  type        = string
}

variable "project_id" {
  description = "project Id in which resources to be created"
  type        = string
}
