resource "azurerm_storage_account" "Testing-Storage-Account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.Testing-Resource-Group.name
  location                 = azurerm_resource_group.Testing-Resource-Group.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}