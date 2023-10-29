data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = var.project_id
  name                       = "private-cluster"
  region                     = var.subnets[0].subnet_region
  network                    = module.vpc.network_name
  subnetwork                 = var.subnets[0].subnet_name
  ip_range_pods              = "${var.subnets[0].subnet_name}-pods"
  ip_range_services          = "${var.subnets[0].subnet_name}-services"
  remove_default_node_pool   = true
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "n1-standard-2"
      node_locations            = "us-west1-a"
      min_count                 = 2
      max_count                 = 10
      local_ssd_count           = 0
      spot                      = false
      local_ssd_ephemeral_count = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      service_account           = resource.google_service_account.wisa_account.email
      preemptible               = false
      initial_node_count        = 2
    },
  ]

   node_pools_oauth_scopes = {
    all = ["https://www.googleapis.com/auth/cloud-platform"]

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
  


  master_authorized_networks =  [ 
    {
      cidr_block   = "35.235.240.0/20"
      display_name = "Google IAP access"
    },
    {
      cidr_block   = "49.37.39.63/32"
      display_name = "Private IP"
    }
  ]
}

resource "kubernetes_secret" "gke_cloud_sql_secrets" {
  metadata {
    name = "gke-cloud-sql-secrets"
  }

  data = {
    database = resource.google_sql_database.default.name
    username = resource.google_sql_user.default.name
    password = resource.google_sql_user.default.name
  }
}