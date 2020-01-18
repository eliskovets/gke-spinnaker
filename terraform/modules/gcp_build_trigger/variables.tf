variable "repo_name" {
  description = "Name of the repository. For example: The name for https://github.com/googlecloudplatform/cloud-builders is 'cloud-builders'."
}
variable "branch_name" {
  default = "release"
}

variable "repo_owner" {
  description = "Owner of the repository. For example: The owner for https://github.com/googlecloudplatform/cloud-builders is 'googlecloudplatform'."
}
