output "vpc_link" {
  value = module.vpc.network_self_link
}

output "cloud-sql" {
  value =  resource.google_sql_database_instance.main_primary.self_link
}

