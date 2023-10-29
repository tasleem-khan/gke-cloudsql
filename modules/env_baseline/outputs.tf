# output "env_folder" {
#   description = "Environment folder created under parent."
#   value       = google_folder.env.name
# }


# output "host_project_id" {
#   description = "Host Project ID"
#   value       = module.host-project.project_id
# }

# output "service_project_id" {
#   description = "Service Project ID"
#   value       = module.service-project.project_id
# }

# output "host_network_name" {
#   description = "Host Network Name"
#   value       = module.vpc.network_name
# }

# output "default_network_tier" {
#   description = "Default Network Service Tier for resources created in this project. If unset, the value will not be modified. See https://cloud.google.com/network-tiers/docs/using-network-service-tiers and https://cloud.google.com/network-tiers."
#   value     = module.vpc.network_name
# }

# output "subnet_01" {
#    description = "Common configuration data to be used in other steps."
#    value = local.subnet_01
# }

# output "sa_email" {
#   description = "Service Account Email"
#   value       = module.service-project.service_account_email
# }

output "vpc_link" {
  value = module.vpc.network_self_link
}

output "cloud-sql" {
  value =  resource.google_sql_database_instance.main_primary.self_link
}

