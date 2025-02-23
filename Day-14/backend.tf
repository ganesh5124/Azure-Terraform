resource "azurerm_resource_group" "backend-store" {
  name = "state-file-rg"
  location = "East US"
}


resource "azurerm_storage_account" "backend-store" {
  name = "statefilestoragemqyc"
  resource_group_name = azurerm_resource_group.backend-store.name
  location = azurerm_resource_group.backend-store.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  depends_on = [azurerm_resource_group.backend-store]
}

resource "azurerm_storage_container" "backend-store" {
  name = "statefilecontainer"
  storage_account_name = azurerm_storage_account.backend-store.name
  container_access_type = "private"
  depends_on = [azurerm_storage_account.backend-store, azurerm_resource_group.backend-store, azurerm_resource_group.backend-store]
}