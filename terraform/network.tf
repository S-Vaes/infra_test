resource "hcloud_network" "k8s_network" {
    name     = "k8s-network"
    ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "k8s_subnet" {
    network_id = hcloud_network.k8s_network.id
    type       = "cloud"
    network_zone = "eu-central"
    ip_range   = "10.0.1.0/24"
}
