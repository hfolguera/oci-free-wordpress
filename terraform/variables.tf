variable "tenancy_ocid" {
}

variable "compartment_id" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
    default = "eu-frankfurt-1"
}

variable "workload_prefix"{
    description = "Prefix to add to all resources"
    type = string
}
