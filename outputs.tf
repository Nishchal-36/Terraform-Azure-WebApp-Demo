output "resource_group_name" {
  description = "Name of the created resource group"
  value       = module.resource_group.resource_group_name
}

output "load_balancer_public_ip" {
  description = "Public IP address of the load balancer"
  value       = module.load_balancer.public_ip_address
}

output "vm_names" {
  description = "Names of the created virtual machines"
  value       = module.virtual_machines.vm_names
}

output "rdp_connection_strings" {
  description = "RDP connection strings for each VM"
  value       = [
    for i in range(var.vm_count) : 
    "mstsc /v:${module.load_balancer.public_ip_address}:${50001 + i}"
  ]
}
