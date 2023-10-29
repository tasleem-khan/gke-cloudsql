resource "google_artifact_registry_repository" "gke_cloud_sql_repo" {
    repository_id       = "gke-cloud-sql-repo"
    format              = "docker"
    description         = "GKE cloud-sql sample app"
}