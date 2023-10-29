#define subnet name
locals {
  subnet_01 = "${var.environment}-subnet-01"
  subnet_02 = "${var.environment}-subnet-02"
}


module "env" {
  source              = "../../modules/env_baseline"
  project_id          = var.project_id
  env                 = var.environment
  remote_state_bucket = var.remote_state_bucket
  subnets = [
    {
      subnet_name           = local.subnet_01
      subnet_ip             = "10.127.0.0/20"
      subnet_region         = "us-west1"
      subnet_flow_logs      = false
      subnet_private_access = true
      secondary_ranges = {
        "$(local.subnet_01)-1" = {
          range_name    = "${local.subnet_01}-pods"
          ip_cidr_range = "100.64.192.0/20"
        },
        "$(local.subnet_01)-2" = {
          range_name    = "${local.subnet_01}-services"
          ip_cidr_range = "192.168.64.0/24"
        }

      }
    },
    {
      subnet_name           = local.subnet_02
      subnet_ip             = "10.200.0.0/20"
      subnet_region         = "us-west1"
      subnet_private_access = true
      subnet_flow_logs      = false
      secondary_ranges      = {}
    }
  ]
}
