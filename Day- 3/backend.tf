resource "azurerm_resource_group" "backend-store" {
  name = "state-file-rg"
  location = "East US"
}

resource "random_string" "random_string" {
  length = 4
  special = false
  upper = false
  numeric = false 
}

resource "azurerm_storage_account" "backend-store" {
  name = "statefilestorage${random_string.random_string.result}"
  resource_group_name = azurerm_resource_group.backend-store.name
  location = azurerm_resource_group.backend-store.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backend-store" {
  name = "statefilecontainer"
  storage_account_id = azurerm_storage_account.backend-store.id
  container_access_type = "private"
}