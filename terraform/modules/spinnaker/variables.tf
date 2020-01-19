variable "service_account_json_b64_encoded" {
  description = "Service account's credentials in json format"
}

variable "gcr_email" {
  description = "Google Container Registry Service Account email"
}

variable "gcr_images_list" {
  description = "GCR docker images list"
  type = "list"
}