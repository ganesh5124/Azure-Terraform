
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.teleforce-prod.name
  location            = azurerm_resource_group.teleforce-prod.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "public_subnets" {
  count                = length(var.public_subnet_address_prefixes)
  name                 = "teleforce-prod-public-subnet-${count.index+1}"
  resource_group_name  = azurerm_resource_group.teleforce-prod.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.public_subnet_address_prefixes[count.index]]
}

resource "azurerm_subnet" "private_subnets" {
  count                = length(var.private_subnet_address_prefixes)
  name                 = "teleforce-prod-private-subnet-${count.index+1}"
  resource_group_name  = azurerm_resource_group.teleforce-prod.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.private_subnet_address_prefixes[count.index]]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "teleforce-prod-nsg"
  location            = azurerm_resource_group.teleforce-prod.location
  resource_group_name = azurerm_resource_group.teleforce-prod.name
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_nsg_association" {
  count                    = length(var.public_subnet_address_prefixes)
  subnet_id                = azurerm_subnet.public_subnets[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

