locals {
  docker_image = "gcr.io/$PROJECT_ID/github.com/${var.repo_owner}/${var.repo_name}:$SHORT_SHA"
}

resource "google_cloudbuild_trigger" "main" {
  github {
    owner = var.repo_owner
    name = var.repo_name
    push {
      branch = var.branch_name
    }
  }
  build {
    step {
      name = "gcr.io/cloud-builders/docker"
      args = ["build", "-t", local.docker_image, "."]
    }
    images = [local.docker_image]
  }

  description = "Push to release branch"

  provider = "google-beta"
}