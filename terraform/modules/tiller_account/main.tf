resource "kubernetes_service_account" "tiller" {
  automount_service_account_token = true
  metadata {
    name = "tiller"
    namespace = var.namespace
  }
}

# https://github.com/hashicorp/terraform/issues/21008#issuecomment-531496335
resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = kubernetes_service_account.tiller.metadata.0.name
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "cluster-admin"
  }
  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.tiller.metadata.0.name
    namespace = kubernetes_service_account.tiller.metadata.0.namespace
  }
}