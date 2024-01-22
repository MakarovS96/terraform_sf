terraform {
  required_version = " >= 1.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.105.0"
    }
  }

  /*backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket = "bucket-for-tf-state"
    region = "ru-central1-a"
    key = "sf/lemp.tfstate"

    access_key = "YCAJEnylekYj0rfJ_pp-6kcPT"
    secret_key = "YCO7dakrAYnBrJnDPdhT6w-ZYCWHYF3s2D-pNOk7"

    skip_region_validation = true
    skip_credentials_validation = true
  }*/
}

provider "yandex" {
  token = file("./keys/token")
  cloud_id                 = var.cloud
  folder_id                = var.folder
  zone                     = var.zonea
}

# Creating Network

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

# Creating instances

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

# Creating Application Load balancer for instances

resource "yandex_alb_target_group" "lemp" {
  name           = "lemp"
  target {
    subnet_id    = yandex_vpc_subnet.testsubnet1.id
    ip_address   = module.ya_inst_1.internal_ip_address
  }
}

resource "yandex_alb_target_group" "lamp" {
  name           = "lamp"
  target {
    subnet_id    = yandex_vpc_subnet.testsubnet2.id
    ip_address   = module.ya_inst_2.internal_ip_address
  }
}

resource "yandex_alb_backend_group" "back_group" {
  name                     = "backgroup"

  http_backend {
    name                   = "tfback"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.lamp.id, yandex_alb_target_group.lemp.id]
    load_balancing_config {
      panic_threshold      = 90
    }
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "tf-router" {
  name   = "tf-router"
}

resource "yandex_alb_virtual_host" "vh" {
  name           = "tfvh"
  http_router_id = yandex_alb_http_router.tf-router.id
  route {
    name = "route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.back_group.id
        timeout          = "60s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "tf-alb" {
  name        = "tf-alb"
  network_id  = yandex_vpc_network.testnet.id

  allocation_policy {
    location {
      zone_id = var.zonea
      subnet_id = yandex_vpc_subnet.testsubnet1.id
    }
  }

  listener {
    name = "tf-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf-router.id
      }
    }
  }
}
