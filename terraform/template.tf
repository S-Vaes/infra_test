data "template_file" "ansible_inventory" {
  template = file("${path.module}/../templates/hosts.tpl")

  vars = {
    master_ip   = hcloud_server.k8s_master.ipv4_address
    worker_ips  = join(",", hcloud_server.k8s_worker.*.ipv4_address)
  }
}
