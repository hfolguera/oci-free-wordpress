resource "oci_core_instance" "ins-nm-001" {
  #Required
  availability_domain = "DNtv:EU-FRANKFURT-1-AD-3"
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.A1.Flex"

  #Optional
  create_vnic_details {

    #Optional
    #assign_private_dns_record = false
    assign_public_ip       = true
    display_name           = "vnic-nm-001"
    hostname_label         = "nm001"
    private_ip             = "192.168.255.2"
    skip_source_dest_check = false
    subnet_id              = oci_core_subnet.sn-nm-001.id
  }
  display_name = "ins-nm-001"

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    #is_pv_encryption_in_transit_enabled = "false"
    network_type            = "PARAVIRTUALIZED"
    remote_data_volume_type = "PARAVIRTUALIZED"
  }
  metadata = { "ssh_authorized_keys" : "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8P7aGIPCzbLBgiZlI7TRJ+EJb8/QXbeNevtha3HvABlNtrTFLYCNk4osryyXNuLu5eH9xLcyRFVWV1Uy4NOC/HCcCLc86E3IGN+M2Q68MY/Q2ZgCL8pEWOxC5OZ2sbp3B1535YiBKY8pz6eWdlAm+4w+RwQb8I0iNs1LJGzKnqQhVpd+wsIv5fxmb7cOW7uGADIRe+w3BwrUUqWJY7SqzNpmHVJj6sqWgbUHLeE2o/8QyDU0nkBdm0csLEijIoiPZ8QKXAyWnzNWlEHzpVWPTceeiWULu72Axxlz+UbCGJv9aIL2vdQ7e9g9LN9985PTAJPUeAhVkUKbwOCzh0wQb hufolgue@Hugs-MacBook-Pro.local" }

  shape_config {

    #Optional
    baseline_ocpu_utilization = ""
    memory_in_gbs             = 24
    ocpus                     = 4
  }
  source_details {
    #Required
    source_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6ueulrtedgclrxznl5pkzhzseddl7b6iq6jhdl3vjm62zhddpxta"
    source_type = "image"
  }
  preserve_boot_volume = false
}