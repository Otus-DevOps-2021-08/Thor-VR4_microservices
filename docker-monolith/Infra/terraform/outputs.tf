output "external_ip_address" {
  value = tolist([for inst in yandex_compute_instance.docker : inst.network_interface.0.nat_ip_address])[*]
}
