variable "gcp_zone" {
  default = "Google Cloud project zone"
}
variable "gcp_project" {
  description = "Google Cloud project name"
}

variable "gcp_cluster_name" {
  description = "Kubernetes cluster name"
}

variable "tiller_image" {
  description = "Tiller image to be installed automatically by terraform provider"
  default = "gcr.io/kubernetes-helm/tiller:v2.16.1"
}