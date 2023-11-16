variable "SSH_PATH" {
  description = "Path to the SSH public key"
  type        = string
}

resource "hcloud_ssh_key" "k8s_key" {
  name       = "hcloud_ssh_key"
  public_key = file(var.SSH_PATH)
}
