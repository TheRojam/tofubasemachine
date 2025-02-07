locals {
  fqdn = "${var.jitsi_sub_domain}.${var.domain_name}"
}

data "hcloud_ssh_key" "ssh_keys" { 
  name = "mbp.mueant.local"

}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "hcloud_server" "server" {
  name        = "${var.jitsi_sub_domain}.${var.domain_name}" 
  image       = var.server.image
  server_type = var.server.server_type
  location    = var.server.location
  backups     = var.server.backups
  ssh_keys    = [data.hcloud_ssh_key.ssh_keys.id]
  user_data   = file("cloudinit.yaml") 
}

data "hcloud_server" "server"{
  name     = "${var.jitsi_sub_domain}.${var.domain_name}"
  depends_on = [hcloud_server.server]
}




















