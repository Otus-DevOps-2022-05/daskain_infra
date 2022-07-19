#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
#  }
#  required_version = ">= 0.13"
#}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"
  labels = {
    tags = "reddit-app"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.app_disk_image
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    # subnet_id = var.subnet_id
    subnet_id = var.subnet_id
    nat       = true
  }
}
resource "null_resource" "app" {
  count = var.enable_provision ? 1 : 0
  triggers = {
    cluster_instance_ids = yandex_compute_instance.app.id
  }
  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app.network_interface[0].nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    content     = templatefile("${path.module}/files/puma.service.j2", { mongod_ip = var.mongod_ip })
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }

}
