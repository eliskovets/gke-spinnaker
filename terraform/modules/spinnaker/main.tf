resource "null_resource" "emulate_dependency" {
  triggers = {
    value = var.dependency
  }
}

resource "kubernetes_namespace" "spinnaker" {
  metadata {
    name = "spinnaker"
  }
}

resource "helm_release" "spinnaker" {
  depends_on = [null_resource.emulate_dependency]
  chart = "stable/spinnaker"
  name = "spinnaker"
  version = "1.23.0"
  namespace = kubernetes_namespace.spinnaker.metadata.0.name
  timeout = 600
}