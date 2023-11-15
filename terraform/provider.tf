terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.29"  # Specify a version here
    }
  }
}

provider "hcloud" {
    token = var.hcloud_token
}
