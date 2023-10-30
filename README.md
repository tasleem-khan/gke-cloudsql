<!-- BEGIN_TF_DOCS -->
# Connecting to Cloud SQL (Postgres) from a Go web app

This repo contains the Go source code for a simple web app that can be deployed to App Engine Standard. It is a demonstration of how to connect to a Postgres instance in Cloud SQL.

## DESIGN
![alt text](https://github.com/tasleem-khan/gke-cloudsql/blob/main/docs/images/GKE-CLOUDSQL.png?raw=true)
<img src="https://github.com/tasleem-khan/gke-cloudsql/blob/main/docs/images/GKE-CLOUDSQL.png" height="60" width="60" >

## Requirements

1. Clone this repo.
2. upload into your private git repository.
3. Connect Repository using cloud build. choose cloudbuild.yaml file for configuration.
4. Create trigger.
5. Make Sure you provide enough Iam permissions to your service account for cloud build.(cloud sql client,network admin,Iam service account creator,GKE admin).

## Code File Structure
 ```├──database-sql  - Application Code as well as Kubernetes configurations file.
    ├── envs      
    │   ├── development             Environment
    │       ├── backend.tf          Backend bucket for State file
    │       ├── main.tf             Code calling module
    │       ├── Outputs.tf          Output from this module
    |       ├── terraform.tfvars    tfvars file
    |       ├── variables.tf        variables 
    |       ├── versions.tf         provider config
    │          
    ├── modules      
    │   ├── env_baseline             
    │       ├── artifact_registry.tf          Creating Registry for images
    │       ├── custom-vpc.tf                 Create VPC
    │       ├── enabled-services.tf           Enable Services
    |       ├── firewall.tf                   Create Firewall
    |        ├── gke.tf                       Craete GKE
    |       ├── outputs.tf                    Module Ouput 
    |        ├── service_account.tf           Service Account Creation and WIF 
    |        ├── sql.tf                       Create Postgres Instance 
    |       ├── variables.tf                  variables 
    |       ├── versions.tf                   provider config
```    

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.50 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 3.50 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.50 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 3.50 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | n/a |
| <a name="module_my-app-workload-identity"></a> [my-app-workload-identity](#module\_my-app-workload-identity) | terraform-google-modules/kubernetes-engine/google//modules/workload-identity | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 7.1 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_service_networking_connection.private_vpc_connection](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_networking_connection) | resource |
| [google_artifact_registry_repository.gke_cloud_sql_repo](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |
| [google_project_iam_member.workload_service_account_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.wisa_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_sql_database.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.main_primary](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [kubernetes_secret.gke_cloud_sql_secrets](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_network_tier"></a> [default\_network\_tier](#input\_default\_network\_tier) | Default Network Service Tier for resources created in this project. If unset, the value will not be modified. See https://cloud.google.com/network-tiers/docs/using-network-service-tiers and https://cloud.google.com/network-tiers. | `string` | `""` | no |
| <a name="input_env"></a> [env](#input\_env) | The environment to prepare (ex. development) | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | project Id in which resources to be created | `string` | n/a | yes |
| <a name="input_remote_state_bucket"></a> [remote\_state\_bucket](#input\_remote\_state\_bucket) | Backend bucket to load Terraform Remote State Data from previous steps. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet configurations | <pre>list(object({<br>    subnet_name           = string<br>    subnet_ip             = string<br>    subnet_region         = string<br>    subnet_private_access = bool<br>    subnet_flow_logs      = bool<br>    secondary_ranges      = map(object({<br>      range_name    = string<br>      ip_cidr_range = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_workload_roles"></a> [workload\_roles](#input\_workload\_roles) | list of roles for workloads service account | `map(any)` | <pre>{<br>  "artifact_registry": "roles/artifactregistry.admin",<br>  "cloud_sql_client": "roles/cloudsql.client",<br>  "container_registry": "roles/containerregistry.ServiceAgent",<br>  "log_writer": "roles/logging.logWriter",<br>  "monitoring_admin": "roles/monitoring.admin",<br>  "network_user": "roles/compute.networkUser",<br>  "secretmanager": "roles/secretmanager.secretAccessor",<br>  "storage_admin": "roles/storage.admin",<br>  "token_creator": "roles/iam.serviceAccountTokenCreator"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloud-sql"></a> [cloud-sql](#output\_cloud-sql) | n/a |
| <a name="output_vpc_link"></a> [vpc\_link](#output\_vpc\_link) | n/a |
<!-- END_TF_DOCS -->