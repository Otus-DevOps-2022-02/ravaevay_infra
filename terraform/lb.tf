resource "yandex_alb_target_group" "load_balancer_target_group" {
  name      = "my-target-group"
  depends_on = [yandex_compute_instance.app]


  target {
    subnet_id = var.subnet_id
    ip_address   = yandex_compute_instance.app[0].network_interface.0.ip_address
  }

  target {
    subnet_id = var.subnet_id
    ip_address   = yandex_compute_instance.app[1].network_interface.0.ip_address
  }

}

resource "yandex_alb_backend_group" "reddit-backend-group" {
  name      = "reddit-backend-group"

  http_backend {
    name = "reddit-http-backend"
    weight = 1
    port = 9292
    target_group_ids = ["${yandex_alb_target_group.load_balancer_target_group.id}"]

    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
    http2 = "true"
  }
}

resource "yandex_alb_http_router" "http-router" {
  name      = "my-http-router"
  labels = {
    tf-label    = "reddit-http-router"
    #empty-label = ""s
  }
}



 resource "yandex_alb_load_balancer" "reddit-load-balancer" {
   name        = "reddit-load-balancer"

   network_id  = var.network_id

   allocation_policy {
     location {
       zone_id   = var.zone
       subnet_id = var.subnet_id
     }
   }

   listener {
     name = "reddit-listener"
     endpoint {
       address {
         external_ipv4_address {
         }
       }
       ports = [ 9292 ]
     }
     http {
      handler {
        http_router_id = yandex_alb_http_router.http-router.id
      }
   }
   }
   }
