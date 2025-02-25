resource "azurerm_virtual_network" "telforce-prod" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.telforce-rg.name
  location            = azurerm_resource_group.telforce-rg.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "telforce-prod-public-subnet" {
    count                = length(var.prod_public_subnets)
    name                 = var.prod_public_subnets[count.index]
    resource_group_name  = azurerm_resource_group.telforce-rg.name
    virtual_network_name = azurerm_virtual_network.telforce-prod.name
    address_prefixes     = [element(var.prod_public_subnet_address, count.index)]
}

resource "azurerm_subnet" "telforce-prod-private-subnet" {
    count                = length(var.prod_private_subnets)
    name                 = var.prod_private_subnets[count.index]
    resource_group_name  = azurerm_resource_group.telforce-rg.name
    virtual_network_name = azurerm_virtual_network.telforce-prod.name
    address_prefixes     = [element(var.prod_private_subnet_address, count.index)]
}

resource "azure_subnet_network_security_group_association" "telforce-prod-public-subnet-nsg" {
    count                    = length(var.prod_public_subnets)
    subnet_id                = azurerm_subnet.telforce-prod-public-subnet[count.index].id
    network_security_group_id = azurerm_network_security_group.telforce-prod-nsg.id
}


