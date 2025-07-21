variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
}

variable "vm_size" {
  description = "Size of the VMs"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
  sensitive   = true
}

variable "load_balancer_backend_pool_id" {
  description = "ID of the load balancer backend pool"
  type        = string
}

variable "nat_rule_ids" {
  description = "List of NAT rule IDs"
  type        = list(string)
}

variable "custom_messages" {
  description = "Custom messages for each VM"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}
