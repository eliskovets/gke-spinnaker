variable "gcp_zone" {
  default = "Google Cloud project zone"
}
variable "gcp_project" {
  description = "Google Cloud project name"
}

variable "gcp_cluster_name" {
  description = "Kubernetes cluster name"
}

# Github repo settings
variable "github_repo_owner" {
  description = "Owner of the repository. For example: The owner for https://github.com/googlecloudplatform/cloud-builders is 'googlecloudplatform'."
}
variable "github_repo_name" {
  description = "Name of the repository. For example: The name for https://github.com/googlecloudplatform/cloud-builders is 'cloud-builders'."
}

variable "tiller_image" {
  description = "Tiller image to be installed automatically by terraform provider"
  default = "gcr.io/kubernetes-helm/tiller:v2.16.1"
}