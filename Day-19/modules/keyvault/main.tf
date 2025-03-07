data "azuread_client_config" "current" {}


resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.rgname
  sku_name                    = var.sku_name
  tenant_id                   = data.azuread_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  enable_rbac_authorization   = true
  enabled_for_disk_encryption = true
}
