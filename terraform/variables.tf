variable "hcloud_token" {
    description = "API Token for Hetzner Cloud"
    type        = string
    sensitive   = true
    default     = ""
}

variable "master_server_type" {
    description = "Server type for the nodes"
    default     = "cax21"
}

variable "worker_server_type" {
    description = "Server type for the nodes"
    default     = "cax11"
}

variable "image" {
    description = "OS image for the servers"
    default     = "ubuntu-20.04"
}

variable "location" {
    description = "Location for the cluster"
    default     = "nbg1"
}
