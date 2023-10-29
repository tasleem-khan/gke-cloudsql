output "vpc_link" {
  description = "VPC LINK"
  value = module.vpc.network_self_link
}

output "cloud-sql" {
  description = "CLOUD SQL"  
  value =  resource.google_sql_database_instance.main_primary.self_link
}