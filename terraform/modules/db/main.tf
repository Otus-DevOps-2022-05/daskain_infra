#terraform {
#  required_providers {
#    yandex = {
#      source = "yandex-cloud/yandex"
#    }
#  }
#  required_version = ">= 0.13"
#}

resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
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
      image_id = var.db_disk_image
    }
  }

  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
}
resource "null_resource" "db" {
  count = var.enable_provision ? 1 : 0
  triggers = {
    cluster_instance_ids = yandex_compute_instance.db.id
  }
  connection {
    type        = "ssh"
    host        = yandex_compute_instance.db.network_interface[0].nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    content     = templatefile("${path.module}/files/mongod.conf.j2", { mongod_ip = yandex_compute_instance.db.network_interface.0.ip_address })
    destination = "/tmp/mongod.conf"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}
