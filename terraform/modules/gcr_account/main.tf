data "google_project" "current" {}
data "google_client_openid_userinfo" "current" {}

resource "google_service_account" "gcr-account" {
  account_id = var.account_name
  display_name = var.account_name
}

resource "google_project_iam_member" "project-browser-role-binding" {
  role = "roles/browser"
  member = "serviceAccount:${google_service_account.gcr-account.email}"
}

resource "google_project_iam_member" "project-storage-role-binding" {
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.gcr-account.email}"
}

resource "google_service_account_key" "key" {
  service_account_id = google_service_account.gcr-account.name
  public_key_type = "TYPE_X509_PEM_FILE"
}