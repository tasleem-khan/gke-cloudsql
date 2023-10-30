<!-- BEGIN_TF_DOCS -->
## Prerequisites

Before using this Terraform script, you need to:

1. Have [Terraform](https://www.terraform.io/downloads.html) installed.
2. Have a Google Cloud Platform (GCP) account.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Resource and Module Description
<pre>1. Module: project-services                         - This module enables Google Cloud services in your project</pre>
<pre>2. Module: vpc                                      - This module creates a GCP Virtual Private Cloud (VPC)</pre>
<pre>3. Resource: google_compute_firewall                - This resource defines a firewall rule to allow SSH access</pre>
<pre>4. Resource: google_compute_instance                - This resource creates an instance (exemplar) with a startup script</pre>
<pre>5. Resource: google_compute_snapshot                - This resource creates a snapshot</pre>
<pre>6. google_compute_image                             - This resource creates a GCP Compute Engine image</pre>
<pre>7. Resource: google_compute_instance_template       - This resource defines an instance template</pre>
<pre>8. Resource: google_compute_target_pool             - This resource defines a target pool</pre>
<pre>9. Resource: google_compute_health_check            - This resource defines a health check</pre>
<pre>10.Resource: google_compute_instance_group_manager  - This resource defines an instance group manager</pre>

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gce-lb-http"></a> [gce-lb-http](#module\_gce-lb-http) | GoogleCloudPlatform/lb-http/google | ~> 6.3 |
| <a name="module_project-services"></a> [project-services](#module\_project-services) | terraform-google-modules/project-factory/google//modules/project_services | ~> 13.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_instance_group_manager.main](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_instance_group_manager) | resource |
| [google_compute_autoscaler.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_autoscaler) | resource |
| [google_compute_firewall.private-allow-ssh](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_health_check.autohealing](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_image.exemplar](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_image) | resource |
| [google_compute_instance.exemplar](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_instance_template.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance_template) | resource |
| [google_compute_snapshot.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_snapshot) | resource |
| [google_compute_target_pool.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_target_pool) | resource |
| [time_sleep.startup_completion](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [http_http.check](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [local_file.index](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | The name of this particular deployment, will get added as a prefix to most resources. | `string` | `"load-balanced-vms"` | no |
| <a name="input_enable_apis"></a> [enable\_apis](#input\_enable\_apis) | Whether or not to enable underlying apis in this solution. . | `string` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A map of labels to apply to contained resources. | `map(string)` | <pre>{<br>  "load-balanced-vms": true<br>}</pre> | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | VPC network to deploy VMs in. A VPC will be created if not specified. | `string` | `""` | no |
| <a name="input_network_project_id"></a> [network\_project\_id](#input\_network\_project\_id) | Shared VPC host project ID if a Shared VPC is provided via network\_id. | `string` | `""` | no |
| <a name="input_nodes"></a> [nodes](#input\_nodes) | The number of nodes in the managed instance group | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The Compute Region to deploy to | `string` | n/a | yes |
| <a name="input_subnet_self_link"></a> [subnet\_self\_link](#input\_subnet\_self\_link) | Subnetwork to deploy VMs in. A Subnetwork will be created if not specified. | `string` | `""` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The Compute Zone to deploy to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_console_page_for_load_balancer"></a> [console\_page\_for\_load\_balancer](#output\_console\_page\_for\_load\_balancer) | The url of the load balancer page in console |
| <a name="output_load_balancer_endpoint"></a> [load\_balancer\_endpoint](#output\_load\_balancer\_endpoint) | The url of the front end which we want to surface to the user |
<!-- END_TF_DOCS -->