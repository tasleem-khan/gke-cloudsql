resource "google_compute_firewall" "iap_access" {
  allow {
    protocol =  "tcp"
    ports     = ["9080","9081"]
  }
  description   = "IAP ACCESS"
  direction     = "INGRESS"
  name          = "custom-allow-iap"
  network       = module.vpc.network_name
  priority      = 1000
  project       = module.host-project.project_id
  source_ranges = ["130.211.0.0/22","35.191.0.0/16"]
}