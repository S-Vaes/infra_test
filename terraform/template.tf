data "template_file" "ansible_inventory" {
  template = file("${path.module}/../templates/hosts.tpl")

  vars = {
    master_ip   = hcloud_server.k8s_master.ipv4_address
    worker_ips  = join("\n", formatlist("k8s-worker%s ansible_host=%s ansible_user=root", range(length(hcloud_server.k8s_worker.*.ipv4_address)), hcloud_server.k8s_worker.*.ipv4_address))
  }
}

resource "local_file" "ansible_inventory_file" {
  depends_on = [hcloud_server.k8s_master, hcloud_server.k8s_worker]
  filename = "${path.module}/../ansible/inventory/hosts.ini"
  content  = data.template_file.ansible_inventory.rendered
}
