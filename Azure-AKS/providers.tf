terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.8.0"
        }
         random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    }
    required_version = ">=1.9.0"
    
    backend "azurerm" {
        resource_group_name   = "state-file-rg"
        storage_account_name  = "statefilestorage25350"
        container_name        = "tfstate"
        key                   = "prod.terraform.tfstate"
    }
}

provider "azurerm" {
    features {}
    subscription_id = "eddc191f-363e-4b9b-8a87-a7cda71eb8f5"
}