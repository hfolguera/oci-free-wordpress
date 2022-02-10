resource "oci_core_vcn" "vcn-nm-001" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  cidr_blocks    = ["192.168.255.0/24"]
  display_name   = "vcn-nm-001"
  dns_label      = "vcnnm001"
  is_ipv6enabled = false
}

resource "oci_core_subnet" "sn-nm-001" {
  #Required
  cidr_block     = "192.168.255.0/25"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn-nm-001.id

  #Optional
  display_name               = "sn-nm-001"
  dns_label                  = "snnm001"
  prohibit_internet_ingress  = false
  prohibit_public_ip_on_vnic = false
}

resource "oci_core_default_security_list" "sl-default-nm-001" {
  manage_default_resource_id = oci_core_vcn.vcn-nm-001.default_security_list_id

  #Required
  compartment_id = var.compartment_id

  #Optional
  display_name = "sl-default-nm-001"

  egress_security_rules {
    #Required
    destination = "0.0.0.0/0"
    protocol    = "6" # TCP

    #Optional
    description      = "Allow HTTP traffic"
    destination_type = "CIDR_BLOCK"

    stateless = true
  }

  ingress_security_rules {
    #Required
    protocol = "6"                # TCP
    source   = "79.156.158.47/32" # Use your public IP

    #Optional
    description = "Allow all traffic"

    source_type = "CIDR_BLOCK"
    stateless   = true
  }
  ingress_security_rules {
    #Required
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    #Optional
    description = "Allow HTTP traffic"

    source_type = "CIDR_BLOCK"
    stateless   = true
    tcp_options {

      #Optional
      max = 80
      min = 80
    }
  }
  ingress_security_rules {
    #Required
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    #Optional
    description = "Allow HTTPS traffic"

    source_type = "CIDR_BLOCK"
    stateless   = true
    tcp_options {

      #Optional
      max = 443
      min = 443
    }
  }
  ingress_security_rules {
    #Required
    protocol = "6" # TCP
    source   = oci_core_subnet.sn-nm-001.cidr_block

    #Optional
    description = "Allow internal traffic"

    source_type = "CIDR_BLOCK"
    stateless   = true
  }
}

resource "oci_core_default_route_table" "rt-default-nm-001" {
  manage_default_resource_id = oci_core_vcn.vcn-nm-001.default_route_table_id

  compartment_id = var.compartment_id
  display_name   = "rt-default-nm-001"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ig-nm-001.id
  }
}

resource "oci_core_internet_gateway" "ig-nm-001" {
  #Required
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.vcn-nm-001.id

  #Optional
  enabled      = true
  display_name = "ig-nm-001"
}