provider "kubernetes" {
  config_context_cluster = var.k8s_settings.config_context_cluster
  config_context = var.k8s_settings.config_context
}

resource "kubernetes_service_account" "tiller" {
  metadata {
    name = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller" {
  metadata {
    name = "tiller-clusterrolebinding"
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

provider "helm" {
  kubernetes {
    config_context = var.k8s_settings.config_context
  }
  tiller_image = var.tiller_image
  service_account = kubernetes_service_account.tiller.metadata.0.name
  automount_service_account_token = true
}

module "k8s-spinnaker" {
  source = "./modules/spinnaker"

  dependency = kubernetes_cluster_role_binding.tiller.id
}