terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.27.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

# Resource Group Module
module "resource_group" {
  source = "./modules/resource-group"
  
  resource_group_name = var.resource_group_name
  location           = var.location
  environment        = var.environment
}

# Networking Module
module "networking" {
  source = "./modules/networking"
  
  resource_group_name = module.resource_group.resource_group_name
  location           = module.resource_group.location
  vnet_name         = var.vnet_name
  vnet_address_space = var.vnet_address_space
  subnet_name       = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  environment       = var.environment
  
  depends_on = [module.resource_group]
}

# Load Balancer Module
module "load_balancer" {
  source = "./modules/load-balancer"
  
  resource_group_name = module.resource_group.resource_group_name
  location           = module.resource_group.location
  public_ip_name    = var.public_ip_name
  load_balancer_name = var.load_balancer_name
  vm_count          = var.vm_count
  environment       = var.environment
  
  depends_on = [module.resource_group]
}

# Virtual Machines Module
module "virtual_machines" {
  source = "./modules/virtual-machines"
  
  resource_group_name = module.resource_group.resource_group_name
  location           = module.resource_group.location
  subnet_id         = module.networking.subnet_id
  vm_count          = var.vm_count
  vm_size           = var.vm_size
  admin_username    = var.admin_username
  admin_password    = var.admin_password
  load_balancer_backend_pool_id = module.load_balancer.backend_pool_id
  nat_rule_ids      = module.load_balancer.nat_rule_ids
  custom_messages   = var.custom_messages
  environment       = var.environment
  
  depends_on = [module.networking, module.load_balancer]
}
