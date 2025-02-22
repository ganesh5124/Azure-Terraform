# Example for Dynamic Expression by taking vnet, subnet and security group as input
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = "DevVnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.10.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = azurerm_virtual_network.vnet.name == "DevVnet" ? "dev-nsg" : "prod-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
    # Example of dynamic expression
    dynamic "security_rule" {
    for_each = local.security_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }

    }
}

# Splat Expression Example
output "security_rule" {
  value = azurerm_network_security_group.nsg.security_rule[*].name
}