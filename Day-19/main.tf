resource "azurerm_resource_group" "aks-demo" {
  name     = var.rgname
  location = var.location
}

module "Service-principal" {
  source = "./modules/serviceprincipal"
  service_principal_name = var.service_principal_name
  depends_on = [ azurerm_resource_group.aks-demo ]
}

resource "azurerm_role_assignment" "roleasgn" {
  scope                = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id         = module.Service-principal.service_principal_object_id
  depends_on = [ module.Service-principal ]
}

module "keyvault" {
  source = "./modules/keyvault"
  rgname = var.rgname
  location = var.location
  keyvault_name = var.keyvault_name
  sku_name = var.sku_name
  service_principal_name = var.service_principal_name
  service_principal_object_id = module.Service-principal.service_principal_object_id
  service_principal_tenant_id = module.Service-principal.service_principal_tenant_id
  depends_on = [ module.Service-principal ]
}

resource "azurerm_key_vault_secret" "kv-secret" {
  name         = module.Service-principal.client_id
  value        = module.Service-principal.client_secret
  key_vault_id = module.keyvault.keyvault_id
  depends_on = [ module.keyvault ]
}

module "aks" {
    source = "./modules/aks"
    location = var.location
    rgname = var.rgname
    kubernetes_version = var.kubernetes_version
    service_principal_name = var.service_principal_name
    client_id = module.Service-principal.client_id
    client_secret = module.Service-principal.client_secret
    depends_on = [ module.keyvault ]
}

resource "local_file" "kubeconfig" {
  filename = "./kubeconfig"
  content = module.aks.config
  depends_on = [ module.aks ]
  
}