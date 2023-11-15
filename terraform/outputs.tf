output "master_ip" {
  value = hcloud_server.k8s_master.ipv4_address
}

output "worker_ips" {
  value = hcloud_server.k8s_worker.*.ipv4_address
}
