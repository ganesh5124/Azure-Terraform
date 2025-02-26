terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.8.0"
        }
    }
    required_version = ">=1.9.0"
}

provider "azurerm" {
    features {}
    subscription_id = "eddc191f-363e-4b9b-8a87-a7cda71eb8f5"
}

