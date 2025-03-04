terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.8.0"
        }
    }
    required_version = ">=1.9.0"
}

resource "azurerm_resource_group" "Testing-Resource-Group" {
    name     = "Testing-RG"
    location = "East US"
}

provider "azurerm" {
    features {}
    subscription_id = "c5b0c396-1237-4eb0-84bd-3eee44556e69"
}


