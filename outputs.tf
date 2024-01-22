output "internal_ip_address_vm1" {
  description = "Internal IP of vm1"
  value = module.ya_inst_1.internal_ip_address
}

output "external_ip_address_vm1" {
  description = "External IP of vm1"
  value = module.ya_inst_1.external_ip_address
}

output "internal_ip_address_vm2" {
  description = "Internal IP of vm2"
  value = module.ya_inst_2.internal_ip_address
}

output "external_ip_address_vm2" {
  description = "External IP of vm2"
  value = module.ya_inst_2.external_ip_address
}

output "balancer_ip" {
  description = "Application load balancer external IP"
  value = yandex_alb_load_balancer.tf-alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}