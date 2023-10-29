
terraform {
  backend "gcs" {
    bucket = "gke-cloudsql-demo"
    prefix = "terraform/environments/development"
  }
}
