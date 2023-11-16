[masters]
k8s-master ansible_host=${master_ip} ansible_user=root

[workers]
${worker_ips}
