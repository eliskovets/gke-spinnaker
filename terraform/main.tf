provider "google" {
  credentials = file("${path.module}/account.json")
  zone = var.gcp_zone
  project = var.gcp_project
}

# https://github.com/terraform-providers/terraform-provider-kubernetes/issues/347#issuecomment-489971151
data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file = false

  host = module.gke_cluster.host
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = module.gke_cluster.cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    load_config_file = false
    host = module.gke_cluster.host
    client_certificate = module.gke_cluster.client_certificate
    client_key = module.gke_cluster.client_key
    token = data.google_client_config.default.access_token
    cluster_ca_certificate = module.gke_cluster.cluster_ca_certificate
  }
  tiller_image = var.tiller_image
  service_account = module.tiller_account.account_name
  automount_service_account_token = true
}

locals {
  services = [
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "containerregistry.googleapis.com",
    "compute.googleapis.com",
    "deploymentmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "sourcerepo.googleapis.com",
  ]
}

resource "google_project_service" "kubernetes" {
  count = length(local.services)
  project = var.gcp_project
  service = element(local.services, count.index)
  disable_on_destroy = false
}

# Create GKE cluster
module "gke_cluster" {
  source = "./modules/gke_cluster"
  name = var.gcp_cluster_name
}

# Create a service account for tiller
module "tiller_account" {
  source = "./modules/tiller_account"
}

# Finally install spinnaker
module "k8s-spinnaker" {
  source = "./modules/spinnaker"
}