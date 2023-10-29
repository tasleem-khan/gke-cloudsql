# workload service account
resource "google_service_account" "wisa_account" {
  account_id   = "workload-sa"
  display_name = "workload service account"
  project      = var.project_id
}

variable "workload_roles" {
  type        = map(any)
  description = "list of roles for workloads service account"
  default = {
    storage_admin            = "roles/storage.admin"
    log_writer               = "roles/logging.logWriter"
    secretmanager            = "roles/secretmanager.secretAccessor"
    token_creator            = "roles/iam.serviceAccountTokenCreator"
    artifact_registry        = "roles/artifactregistry.admin"
    container_registry       = "roles/containerregistry.ServiceAgent"
    network_user             = "roles/compute.networkUser"
    cloud_sql_client         = "roles/cloudsql.client"
    monitoring_admin         = "roles/monitoring.admin"
  }
}

resource "google_project_iam_member" "workload_service_account_roles" {
  depends_on = [google_service_account.wisa_account]
  project      = var.project_id
  for_each = var.workload_roles
  role    = each.value
  member  = "serviceAccount:${google_service_account.wisa_account.email}"
}


module "my-app-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name                = "gke-cloudsql"
  cluster_name        = module.gke.name
  gcp_sa_name         = google_service_account.wisa_account.account_id
  use_existing_gcp_sa = true
  namespace           = "default"
  project_id          = var.project_id
  roles               = ["roles/secretmanager.secretAccessor","roles/artifactregistry.admin", "roles/compute.networkUser","roles/cloudsql.client"]
  depends_on          = [google_service_account.wisa_account]
}