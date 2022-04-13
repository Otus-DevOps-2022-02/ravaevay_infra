resource "yandex_lb_target_group" "load_balancer_tgroup" {
  name      = "my-target-group"
  region_id = "ru-central1"
  depends_on = [yandex_compute_instance.app]


  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app[0].network_interface.0.ip_address
  }

  target {
    subnet_id = var.subnet_id
    address   = yandex_compute_instance.app[1].network_interface.0.ip_address
  }

}

resource "yandex_lb_network_load_balancer" "reddit-load-balancer" {
  name = "reddit-load-balancer"
  type = "external"

  listener {
    name = "my-listener"
    port = "80"
    target_port = "9292"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

   attached_target_group {
     target_group_id = yandex_lb_target_group.load_balancer_tgroup.id

     healthcheck {
       name = "tcp"
       tcp_options {
         port = 9292
       }
     }
   }
}
