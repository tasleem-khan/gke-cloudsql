output "load_balancer_endpoint" {
  value       = local.lb_endpoint
  description = "The url of the front end which we want to surface to the user"

  precondition {
    condition     = data.http.check.status_code != "200"
    error_message = "LB is not serving yet"
  }
}

output "console_page_for_load_balancer" {
  value       = "https://console.cloud.google.com/net-services/loadbalancing/details/http/${var.deployment_name}-lb-url-map?project=${var.project_id}"
  description = "The url of the load balancer page in console"
}