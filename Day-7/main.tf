# example of count meta-argument in azure resource
resource "azurerm_resource_group" "rg" {
  count = 2
  name     = "rg-${count.index}"
  location = "East US"
}

# Example of depends_on meta-argument in azure resource
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = azurerm_resource_group.rg[0].location
  resource_group_name = azurerm_resource_group.rg[0].name
  address_space       = ["10.0.10.0/16"]
  depends_on = [azurerm_resource_group.rg]
}

# Example of for_each meta-argument in azure resource
resource "azurerm_subnet" "subnet" {
    for_each             = { "subnet1" = "10.0.10.0/24", "subnet2" = "10.0.20.0/24" }
    name                 = each.key
    resource_group_name  = azurerm_resource_group.rg[0].name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefix       = each.value
}

# Example of provider meta-argument in azure resource
provider "azurerm" {
  features {}
}

# Example for loop in terraform
output "rg_name" {
  value = [for rg in azurerm_resource_group.rg : rg.name]
}

output "subnet_name" {
  value = [for subnet in azurerm_subnet.subnet : subnet.name]
}

# Example of lifecycle meta-argument in azure resource
resource "azurerm_storage_account" "storage" {
  name                     = "storageaccount"
  resource_group_name      = azurerm_resource_group.rg[0].name
  location                 = azurerm_resource_group.rg[0].location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  lifecycle {
    ignore_changes = [
      account_replication_type,
    ]
  }
}