output "instance_public_ip" {
  value = oci_core_instance.ins-nm-001.public_ip
}

output "instance_private_ip" {
  value = oci_core_instance.ins-nm-001.private_ip
}

output "loadbalancer_public_ip" {
  value = oci_load_balancer_load_balancer.lb-nm-001.ip_address_details[0].ip_address
}