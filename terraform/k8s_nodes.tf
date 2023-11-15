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
}

resource "hcloud_server" "k8s_worker" {
    count       = 2
    name        = "k8s-worker-${count.index}"
    image       = var.image
    server_type = var.worker_server_type
    location    = var.location
    ssh_keys    = [hcloud_ssh_key.k8s_key.id]
    placement_group_id = hcloud_placement_group.k8s_group.id
    network {
        network_id = hcloud_network.k8s_network.id
        ip         = "10.0.1.1${count.index}"
    }
}

resource "null_resource" "ansible_inventory" {
  depends_on = [hcloud_server.k8s_master, hcloud_server.k8s_worker]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.ansible_inventory.rendered}' > ${path.module}/../ansible/inventory/hosts.ini"
  }
}
