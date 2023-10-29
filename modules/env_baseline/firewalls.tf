# resource "google_compute_firewall" "custom_vpc_allow_icmp" {
#   allow {
#     protocol = "icmp"
#   }
#   description   = "Allows ICMP connections from any source to any instance on the network."
#   direction     = "INGRESS"
#   name          = "custom-vpc-allow-icmp"
#   network       = module.vpc.network_name
#   priority      = 65534
#   project       = module.host-project.project_id
#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_firewall" "custom_vpc_allow_egress" {
#   allow {
#     protocol =  "all"
#   }
#   description   = "Egress Traffic Allowed"
#   direction     = "EGRESS"
#   name          = "custom-allow-egress"
#   network       = module.vpc.network_name
#   priority      = 65534
#   project       = module.host-project.project_id
#   destination_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_firewall" "custom_vpc_allow_tcp" {
#   allow {
#     protocol =  "tcp"
#     ports     = ["80", "8080","443","9080","9081"]
#   }
#   description   = "TCP Ingress Allowed"
#   direction     = "INGRESS"
#   name          = "custom-allow-tcp"
#   network       = module.vpc.network_name
#   priority      = 1000
#   project       = module.host-project.project_id
#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_firewall" "iap_access" {
#   allow {
#     protocol =  "tcp"
#     ports     = ["9080","9081"]
#   }
#   description   = "IAP ACCESS"
#   direction     = "INGRESS"
#   name          = "custom-allow-iap"
#   network       = module.vpc.network_name
#   priority      = 1000
#   project       = module.host-project.project_id
#   source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
# }