provider "yandex" {

  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
  version                  = "0.35"
}

resource "yandex_compute_instance" "docker" {

  count = var.servers_count

  name = "docker-${count.index}"
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"

  }

  labels = {
    tags = "reddit-docker"
  }

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5

  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      size     = 10
      image_id = var.image_id
    }
  }

  network_interface {

    subnet_id = var.subnet_id
    nat       = true
  }
  connection {
    type        = "ssh"
    host        = self.network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.ssh_key_path)
  }
}
