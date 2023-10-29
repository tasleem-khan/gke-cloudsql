resource "google_sql_database_instance" "main_primary" {
  name             = "main-primary"
  database_version = "POSTGRES_14"
  root_password = "root"

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL" # use "REGIONAL" for prod to distribute data storage across zones

    ip_configuration {
      ipv4_enabled    = false        # don't give the db a public IPv4
      private_network = module.vpc.network_self_link # the VPC where the db will be assigned a private IP
    }
  }
  depends_on = [ module.vpc ]
}

resource "google_sql_database" "default" {
    name            = "${resource.google_sql_database_instance.main_primary.name}-db"
    instance        = google_sql_database_instance.main_primary.name
    project         = var.project_id
}

resource "google_sql_user" "default" {
    name        = "${resource.google_sql_database_instance.main_primary.name}-user"
    project     = var.project_id
    instance    = google_sql_database_instance.main_primary.name
    password    = "${resource.google_sql_database_instance.main_primary.name}-user"
}