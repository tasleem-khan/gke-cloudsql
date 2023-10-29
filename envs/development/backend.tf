
terraform {
  backend "gcs" {
    bucket = "gke-cloudsql"
    prefix = "terraform/environments/development"
  }
}
