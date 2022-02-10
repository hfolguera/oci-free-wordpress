resource "oci_load_balancer_load_balancer" "lb-nm-001" {
  #Required
  compartment_id = var.compartment_id
  display_name   = "lb-nm-001"
  shape          = "flexible"
  subnet_ids     = [oci_core_subnet.sn-nm-001.id]

  #Optional
  is_private = false
  shape_details {
    #Required
    maximum_bandwidth_in_mbps = 10
    minimum_bandwidth_in_mbps = 10
  }
}

resource "oci_load_balancer_backend_set" "lbbs-nm-001" {
  #Required
  health_checker {
    #Required
    protocol = "HTTP"

    #Optional
    url_path    = "http://130.61.136.41"
    return_code = 200
  }
  load_balancer_id = oci_load_balancer_load_balancer.lb-nm-001.id
  name             = "lbbs-nm-001"
  policy           = "ROUND_ROBIN"
}

resource "oci_load_balancer_backend" "lbb-nm-001" {
  #Required
  backendset_name  = oci_load_balancer_backend_set.lbbs-nm-001.name
  ip_address       = "192.168.255.2"
  load_balancer_id = oci_load_balancer_load_balancer.lb-nm-001.id
  port             = 80
  backup           = false
  drain            = false
}

resource "oci_load_balancer_listener" "lbls-nm-001" {
  #Required
  default_backend_set_name = oci_load_balancer_backend_set.lbbs-nm-001.name
  load_balancer_id         = oci_load_balancer_load_balancer.lb-nm-001.id
  name                     = "lbls-nm-001"
  port                     = 80
  protocol                 = "HTTP"

  #Optional
  // ssl_configuration {
  //     #Optional
  //     certificate_name = oci_load_balancer_certificate.test_certificate.name
  //     certificate_ids = var.listener_ssl_configuration_certificate_ids
  //     cipher_suite_name = var.listener_ssl_configuration_cipher_suite_name
  //     protocols = var.listener_ssl_configuration_protocols
  //     server_order_preference = var.listener_ssl_configuration_server_order_preference
  //     trusted_certificate_authority_ids = var.listener_ssl_configuration_trusted_certificate_authority_ids
  //     verify_depth = var.listener_ssl_configuration_verify_depth
  //     verify_peer_certificate = var.listener_ssl_configuration_verify_peer_certificate
  // }
}