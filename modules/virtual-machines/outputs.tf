output "vm_names" {
  description = "Names of the virtual machines"
  value       = azurerm_windows_virtual_machine.main[*].name
}

output "vm_ids" {
  description = "IDs of the virtual machines"
  value       = azurerm_windows_virtual_machine.main[*].id
}

output "network_interface_ids" {
  description = "IDs of the network interfaces"
  value       = azurerm_network_interface.main[*].id
}
