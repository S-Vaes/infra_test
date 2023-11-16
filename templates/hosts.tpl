[k8s_master]
k8s-master ansible_host=${master_ip}

[k8s_workers]
${worker_ips}
