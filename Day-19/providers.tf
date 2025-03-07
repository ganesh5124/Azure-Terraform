terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.12.0"
        }

        azuread = {
            source = "hashicorp/azuread"
            version = "~> 3.0.2"
        }
    }
    required_version = ">= 1.8.4"
    
}

provider "azurerm" {
    features {
        key_vault {
            purge_soft_delete_on_destroy = true
        }
    }
}

provider "azuread" {
}
