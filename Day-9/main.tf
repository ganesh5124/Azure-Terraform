provider "azurerm" {
  features {}
  subscription_id = "c5b0c396-1237-4eb0-84bd-3eee44556e69"
}

resource "azurerm_resource_group" "rg" {
  name     = "myResourceGroup"
  location = "East US"
}

# project naming convention
# Your company requires all resource names to be lowercase and replace spaces with hyphen (-).
locals {
  project_name = "my project"
  project_name_lower = replace(lower(local.project_name), " ", "-")
}

output "project_name_lower" {
  value = local.project_name_lower
}

# Resource Tagging 
# You need to combine default company tags with environment-specific tags.
locals {
  company_tags = {
    owner = "admin"
    environment = "dev"
  }

  environment_tags = {
    environment = "prod"
    cost_center = "12345"
  }

  all_tags = merge(local.company_tags, local.environment_tags)
}

output "all_tags" {
  value = local.all_tags
}
# Azure storage account names must be less than 24 characters and use only lowercase letters and numbers by using substring function.
locals {
  storage_account_name = "my-storage-account"
  updated_storage_name = substring(lower(local.storage_account_name), 0, 24)
}
resource "azurerm_storage_account" "storage" {
  name                     = local.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.all_tags
}

output "updated_storage_name" {
  value = local.updated_storage_name
}

