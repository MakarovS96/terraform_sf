terraform {
  required_version = " >= 1.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.105.0"
    }
  }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "bucket-for-tf-state"
    region = "ru-central1-a"
    key = "sf/lemp.tfstate"

    access_key = "YCAJEnylekYj0rfJ_pp-6kcPT"
    secret_key = "YCO7dakrAYnBrJnDPdhT6w-ZYCWHYF3s2D-pNOk7"

    skip_region_validation = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = file("./keys/sasf.json")
  cloud_id                 = var.cloud
  folder_id                = var.folder
  zone                     = var.zonea
}

resource "yandex_vpc_network" "testnet" {}

resource "yandex_vpc_subnet" "testsubnet1" {
  zone = var.zonea
  network_id = yandex_vpc_network.testnet.id
  v4_cidr_blocks = ["10.2.0.0/16"]
}

resource "yandex_vpc_subnet" "testsubnet2" {
  zone = var.zoneb
  network_id = yandex_vpc_network.testnet.id
  v4_cidr_blocks = ["10.3.0.0/16"]
}

module "ya_inst_1" {
  source = "./modules/compute_instance"
  instance_family_image = "lemp"
  vpc_subnet_id = yandex_vpc_subnet.testsubnet1.id
  zone = var.zonea
}

module "ya_inst_2" {
  source = "./modules/compute_instance"
  instance_family_image = "lamp"
  vpc_subnet_id = yandex_vpc_subnet.testsubnet2.id
  zone = var.zoneb
}

