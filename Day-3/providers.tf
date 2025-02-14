terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.8.0"
        }
    }
    required_version = ">=1.9.0"
    
    # backend "azurerm" {
    #     resource_group_name   = "state-file-rg"
    #     storage_account_name  = "statefilestoragemqyc"
    #     container_name        = "statefilecontainer"
    #     key                   = "dev.terraform.tfstate"
    # }
}

resource "azurerm_resource_group" "Testing-Resource-Group" {
    name     = "Testing-RG"
    location = "East US"
}

provider "azurerm" {
    features {}
    subscription_id = "eddc191f-363e-4b9b-8a87-a7cda71eb8f5"
}
