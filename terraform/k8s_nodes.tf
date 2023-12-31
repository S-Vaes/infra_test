resource "hcloud_placement_group" "k8s_group" {
  name = "k8s_group"
  type = "spread"
  labels = {
    key = "lab1"
  }
}

resource "hcloud_server" "k8s_master" {
    name        = "k8s-master"
    image       = var.image
    server_type = var.master_server_type
    location    = var.location
    ssh_keys    = [hcloud_ssh_key.k8s_key.id]
    placement_group_id = hcloud_placement_group.k8s_group.id
    network {
        network_id = hcloud_network.k8s_network.id
        ip         = "10.0.1.9"
    }

    labels = {"nixos-flavour": "nixos-infect"}
    user_data = file("cloudinit.yaml")
}

resource "hcloud_server" "k8s_worker" {
    count       = 2
    name        = "k8s-worker${count.index}"
    image       = var.image
    server_type = var.worker_server_type
    location    = var.location
    ssh_keys    = [hcloud_ssh_key.k8s_key.id]
    placement_group_id = hcloud_placement_group.k8s_group.id
    network {
        network_id = hcloud_network.k8s_network.id
        ip         = "10.0.1.1${count.index}"
    }

    labels = {"nixos-flavour": "nixos-infect"}
    user_data = file("cloudinit.yaml")
}
