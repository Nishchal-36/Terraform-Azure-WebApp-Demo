variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs (for NAT rules)"
  type        = number
}

variable "environment" {
  description = "Environment name"
  type        = string
}
