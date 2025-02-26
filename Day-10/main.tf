terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.8.0"
        }
    }
    required_version = ">=1.9.0"
    
    backend "azurerm" {
        resource_group_name   = "state-file-rg"
        storage_account_name  = "statefilestoragemqyc"
        container_name        = "statefilecontainer"
        key                   = "dev.terraform.tfstate"
    }
}

resource "azurerm_resource_group" "Testing-Resource-Group" {
    name     = "Testing-RG"
    location = "East US"
}

provider "azurerm" {
    features {}
    subscription_id = "eddc191f-363e-4b9b-8a87-a7cda71eb8f5"
}

variable "prefix" {
    type    = string
    default = "testing"
}

data "azurerm_resource_group" "shared-rg"{
    name     = "shared-rg"
    location = "East US"
}


data "azurerm_virtual_network" "shared-vnet" {
    name                = "com-vnet"
    resource_group_name = data.azurerm_resource_group.shared-rg.name
}

data "azurerm_subnet" "shared-subnet" {
    name                 = "devops"
    virtual_network_name = data.azurerm_virtual_network.shared-vnet.name
    resource_group_name  = data.azurerm_resource_group.shared-rg.name
}

resource "azurerm_resource_group" "dev" {
    name     = "${var.prefix}-rg"
    location = data.azurerm_resource_group.shared-rg.location
}

resource "azurerm_network_interface" "demo-nic" {
    name                      = "${var.prefix}-nic"
    resource_group_name       = azurerm_resource_group.dev.name
    location                  = azurerm_resource_group.dev.location
    ip_configuration {
        name                          = "internal"
        subnet_id                     = data.azurerm_subnet.shared-subnet.id
        private_ip_address_allocation = "Dynamic"
    }
  
}


resource "azurerm_virtual_machine" "demo-machine" {
    name                  = "${var.prefix}-vm"
    resource_group_name   = data.azurerm_resource_group.shared-rg.name
    location              = data.azurerm_resource_group.shared-rg.location
    vm_size               = "Standard_DS1_v2"
    network_interface_ids = [azurerm_network_interface.demo-nic.id]
    delete_os_disk_on_termination = true

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "${var.prefix}-osdisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    os_profile {
        computer_name  = "${var.prefix}-vm"
        admin_username = "adminuser"
        admin_password = "Password1234!"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
  
}







