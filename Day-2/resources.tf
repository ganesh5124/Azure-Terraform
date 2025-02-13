
resource "azurerm_storage_account" "Testing-Storage-Account" {
    name                     = "testingstorageaccount"
    resource_group_name      = azurerm_resource_group.Testing-Resource-Group.name
    location                 = azurerm_resource_group.Testing-Resource-Group.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}