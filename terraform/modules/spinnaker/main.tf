resource "kubernetes_namespace" "spinnaker" {
  metadata {
    name = "spinnaker"
  }
}
resource "kubernetes_secret" "docker-registry-secret" {
  metadata {
    name = "docker-registry-secret"
    namespace = kubernetes_namespace.spinnaker.metadata.0.name
  }
  data = {
    "gcr" = base64decode(var.service_account_json_b64_encoded)
  }
}

data "google_project" "current" {}

resource "helm_release" "spinnaker" {
  chart = "stable/spinnaker"
  name = "spinnaker"
  version = "1.23.0"
  namespace = kubernetes_namespace.spinnaker.metadata.0.name
  timeout = 600
  values = [
    templatefile("${path.module}/templates/spinnaker.yaml", {
      gcr_email = var.gcr_email,
      docker_registry_account_secret = kubernetes_secret.docker-registry-secret.metadata.0.name
      project_id = data.google_project.current.project_id
      gcr_images_list = jsonencode(var.gcr_images_list)
    })
  ]
}
