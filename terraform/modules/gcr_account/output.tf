output "private_key" {
  value = google_service_account_key.key.private_key
}

output "service_account_json_b64encoded" {
  value = google_service_account_key.key.private_key
}

output "service_account_email" {
  value = google_service_account.gcr-account.email
}