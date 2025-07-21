# Public IP for Load Balancer
resource "azurerm_public_ip" "main" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment
    Component   = "load-balancer"
  }
}

# Load Balancer
resource "azurerm_lb" "main" {
  name                = var.load_balancer_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = {
    Environment = var.environment
    Component   = "load-balancer"
  }
}

# NAT Rules for RDP
resource "azurerm_lb_nat_rule" "rdp" {
  count                          = var.vm_count
  name                           = "RDP-NAT-${count.index + 1}"
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = 50000 + count.index + 1
  backend_port                   = 3389
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
}

# Backend Pool
resource "azurerm_lb_backend_address_pool" "main" {
  name            = "WebyBEP"
  loadbalancer_id = azurerm_lb.main.id
}

# Health Probe
resource "azurerm_lb_probe" "main" {
  name            = "WebyProbe"
  loadbalancer_id = azurerm_lb.main.id
  protocol        = "Tcp"
  port            = 80
}

# Load Balancer Rule
resource "azurerm_lb_rule" "main" {
  name                            = "WebyRule"
  loadbalancer_id                 = azurerm_lb.main.id
  protocol                        = "Tcp"
  frontend_port                   = 80
  backend_port                    = 80
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_address_pool_ids        = [azurerm_lb_backend_address_pool.main.id]
  probe_id                        = azurerm_lb_probe.main.id
}
