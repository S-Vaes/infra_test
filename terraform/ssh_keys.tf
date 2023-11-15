resource "hcloud_ssh_key" "k8s_key" {
  name       = "hcloud_ssh_key"
  public_key = file(var.ssh_public_key_path)
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  default     = "~/.ssh/hetzner_kube.pub"
}
