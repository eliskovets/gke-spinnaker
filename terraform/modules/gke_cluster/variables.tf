variable "name" {
  description = "The name of the cluster, unique within the project and zone."
}

variable "node_pool_name" {
  default = "default-pool"
  description = "The name of the node pool"
}

variable "initial_node_count" {
  default = 3
  description = "The number of nodes to create in this cluster (not including the Kubernetes master). Default to 3"
}

variable "min_node_count" {
  default = 1
  description = "Minimum number of nodes in the NodePool. Must be >=1 and <= max_node_count Default to 1"
}

variable "max_node_count" {
  default = 3
  description = "Maximum number of nodes in the NodePool. Must be >= min_node_count. Default to 3"
}

variable "machine_type" {
  default = "n1-standard-1"
  description = "The name of a Google Compute Engine machine type. Defaults to n1-standard-4"
}

variable "tags" {
  type = "list"
  default = ["spinnaker"]
  description = "The list of instance tags applied to all nodes in the pool."
}

variable "oauth_scopes" {
  type = "list"

  default = [
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
  ]
}