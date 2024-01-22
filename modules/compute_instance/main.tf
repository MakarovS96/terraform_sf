terraform {
  required_version = " >= 1.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.105.0"
    }
  }
}

data "yandex_compute_image" "my_image" {
    family = var.instance_family_image
}

resource "yandex_compute_instance" "vm" {
  name = "terraform-${var.instance_family_image}"

  zone = var.zone

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }
  }

  network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("./keys/sf_rsa.pub")}"
  }
}