# resource "google_project_service" "enable_services_host_project" {
#   project =  module.project-factory_example_shared_vpc.host_project_id
#   service = "container.googleapis.com"
# }

# resource "google_project_service" "enable_services_service_project" {
#   project =  module.project-factory_example_shared_vpc.service_project.project_id
#   service = "container.googleapis.com"
# }
# resource "google_project_service" "enable_services_monitoring_project" {
#   project =  google_project.monitoring-project.id
#   service = "monitoring.googleapis.com"
#   depends_on = [module.project-iam-bindings]
# }

# resource "google_project_service" "enable_services_osconfig" {
#   project =  module.service-project.project_id
#   service = "osconfig.googleapis.com"
# }

# resource "google_project_service" "enable_services_iap" {
#   project =  module.service-project.project_id
#   service = "iap.googleapis.com"
# }