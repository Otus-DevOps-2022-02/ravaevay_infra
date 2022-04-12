terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_lb_target_group" "load_balancer_target_group" {
  name      = "my-target-group"
  depends_on = [yandex_compute_instance.app[*]]


  target {
    subnet_id = var.subnet_id
    address   = "<внутренний IP-адрес ресурса>"
  }

  target {
    subnet_id = var.subnet_id
    address   = "<внутренний IP-адрес ресурса 2>"
  }

}

resource "yandex_alb_load_balancer" "test-balancer" {
  name        = "my-load-balancer"

  network_id  = yandex_vpc_network.test-network.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.test-subnet.id
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 8080 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.test-router.id
      }
    }
  }
