
module "vpc" {
  source                                 = "terraform-google-modules/network/google"
  version                                = "~> 7.1"
  project_id                             = var.project_id
  network_name                           = "${var.env}-host-network"
  delete_default_internet_gateway_routes = false

  subnets = [
    for subnet in var.subnets : {
      subnet_name           = subnet.subnet_name
      subnet_ip             = subnet.subnet_ip
      subnet_region         = subnet.subnet_region
      subnet_private_access = subnet.subnet_private_access
      subnet_flow_logs      = subnet.subnet_flow_logs
    }
  ]
secondary_ranges = {
  for subnet in var.subnets : subnet.subnet_name => [
    for range_key, range in subnet.secondary_ranges : {
      range_name    = range.range_name
      ip_cidr_range = range.ip_cidr_range
    }
  ]
}


}

# Reserve global internal address range for the peering
resource "google_compute_global_address" "private_ip_address" {
  provider      = google-beta
  project       = var.project_id
  name          = "peering-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = module.vpc.network_self_link
}

# Establish VPC network peering connection using the reserved address range
resource "google_service_networking_connection" "private_vpc_connection" {
  provider                = google-beta
  network                 = module.vpc.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

