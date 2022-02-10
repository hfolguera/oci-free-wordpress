variable "compartment_id" {
}

variable "region" {
  default = "eu-frankfurt-1"
}

variable "workload_prefix" {
  description = "Prefix to add to all resources"
  type        = string
}
