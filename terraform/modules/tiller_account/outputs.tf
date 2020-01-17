# https://github.com/hashicorp/terraform/issues/21008#issuecomment-531496335
output "account_name" {
  value = kubernetes_cluster_role_binding.tiller.metadata.0.name
}