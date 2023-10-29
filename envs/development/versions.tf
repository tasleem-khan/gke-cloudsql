terraform {
  required_version = ">= 1.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.50"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 3.50"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-example-foundation:environments/v3.0.0"
  }

  provider_meta "google-beta" {
    module_name = "blueprints/terraform/terraform-example-foundation:environments/v3.0.0"
  }
}

provider "google" {
  project = var.project_id
  region = "us-west1"
}
