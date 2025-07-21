# Network Interfaces
resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "WebyNIC-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    Environment = var.environment
    Component   = "virtual-machines"
  }
}

# Associate NICs with Load Balancer Backend Pool
resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                   = var.vm_count
  network_interface_id    = azurerm_network_interface.main[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = var.load_balancer_backend_pool_id
}

# Associate NICs with NAT Rules
resource "azurerm_network_interface_nat_rule_association" "main" {
  count                 = var.vm_count
  network_interface_id  = azurerm_network_interface.main[count.index].id
  ip_configuration_name = "internal"
  nat_rule_id          = var.nat_rule_ids[count.index]
}

# Windows Virtual Machines
resource "azurerm_windows_virtual_machine" "main" {
  count                 = var.vm_count
  name                  = "Alucard${count.index}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main[count.index].id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  winrm_listener {
    protocol = "Http"
  }

  provision_vm_agent = true

  tags = {
    Environment = var.environment
    Component   = "virtual-machines"
    VMIndex     = count.index
  }
}

# VM Extensions for IIS Installation
resource "azurerm_virtual_machine_extension" "iis" {
  count                = var.vm_count
  name                 = "install-iis-${count.index}"
  virtual_machine_id   = azurerm_windows_virtual_machine.main[count.index].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = jsonencode({
    commandToExecute = "powershell -ExecutionPolicy Unrestricted -Command \"${base64decode(base64encode(templatefile("${path.module}/templates/install_iis.ps1.tpl", {
      message = var.custom_messages[count.index]
    })))}\""
  })

  depends_on = [azurerm_windows_virtual_machine.main]
}
