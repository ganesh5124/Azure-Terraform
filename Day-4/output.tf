output "storage_account_id" {
  value = azurerm_storage_account.tfstate_storage_account.id
}

output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.tfstate_storage_account.primary_blob_endpoint 
}

############################################################################################################

locals {
  finaltags = {
    environment = "TerraformDemo"
    costcenter = "12345"
    company = "MyCompany"
  }
}