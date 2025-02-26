resource "azurerm_resource_group" "web-app-rg" {
  name     = "web-app-rg"
  location = "East US"
}

resource "azurerm_virtual_network" "web-app-vnet" {
  name                = "web-app-vnet"
  resource_group_name = azurerm_resource_group.web-app-rg.name
  address_space       = ["10.0.0.0/16"]
  location = azurerm_resource_group.web-app-rg.location
}

resource "azurerm_subnet" "web-app-public-subnet1" {
  name                 = "web-app-subnet1"
  resource_group_name  = azurerm_resource_group.web-app-rg.name
  virtual_network_name = azurerm_virtual_network.web-app-vnet.name
  address_prefixes     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
}

resource "azurerm_subnet" "web-app-public-subnet2" {
  name                 = "web-app-subnet2"
  resource_group_name  = azurerm_resource_group.web-app-rg.name
  virtual_network_name = azurerm_virtual_network.web-app-vnet.name
  address_prefixes     = ["10.0.10.0/24", "10.0.20.0/24"]
}