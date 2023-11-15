[master]
master ansible_host=${master_ip}

[workers]
%{ for ip in split(",", worker_ips) ~}
worker ansible_host=${ip}
%{ endfor ~}
