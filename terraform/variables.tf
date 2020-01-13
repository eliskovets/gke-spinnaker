variable "k8s_settings" {
  description = "Kubernetes config context cluster"
  type = "map"
}

variable "tiller_image" {
  description = "Tiller image to be installed automatically by terraform provider"
  default = "gcr.io/kubernetes-helm/tiller:v2.16.1"
}