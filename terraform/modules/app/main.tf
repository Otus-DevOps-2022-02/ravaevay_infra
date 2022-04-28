terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.35"
    }
  }
  required_version = ">= 0.12.0"
}
resource "yandex_compute_instance" "app" {
  name = "reddit-app-${var.name_template}"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type = "ssh"
    #host  = yandex_compute_instance.app[*].network_interface.0.nat_ip_address
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
  provisioner "remote-exec" {
    inline = [
     "export DATABASE_URL=mongod://${var.database_url}:27017"

     ]
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "file" {
    source      = "files/deploy.sh"
    destination = "/tmp/deploy.sh"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
    #inline = [
    # "sudo chmod +x /tmp/deploy.sh",
    #   "sudo /tmp/deploy.sh",
    # ]
  }

}
