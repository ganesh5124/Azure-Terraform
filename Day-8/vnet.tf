resource "azurerm_virtual_network" "prod" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "prod-public-subnet" {
    count                = length(var.prod_public_subnets)
    name                 = var.prod_public_subnets[count.index]
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.prod.name
    address_prefixes     = [element(var.prod_public_subnet_address, count.index)]
}

resource "azurerm_subnet" "prod-private-subnet" {
    count                = length(var.prod_private_subnets)
    name                 = var.prod_private_subnets[count.index]
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.prod.name
    address_prefixes     = [element(var.prod_private_subnet_address, count.index)]
}

resource "azurerm_network_security_group" "prod-nsg" {
    name                = var.nsg_name
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
  
}
resource "azure_subnet_network_security_group_association" "prod-public-subnet-nsg" {
    count                    = length(var.prod_public_subnets)
    subnet_id                = azurerm_subnet.prod-public-subnet[count.index].id
    network_security_group_id = azurerm_network_security_group.prod-nsg.id
}


