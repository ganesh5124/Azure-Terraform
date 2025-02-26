# Create AKS cluster with 2 nodes
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = "Production"
  }
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg"
  location = "East US"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
    location = azurerm_resource_group.rg.location
}

# Create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.10.0/24"]
}

# Create a public IP address
resource "azurerm_public_ip" "publicip" {
  name                = "publicip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

# Create a network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a network security group rule
resource "azurerm_network_security_rule" "http" {
  name                        = "http"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                      = "nic"
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# Create a virtual machine
resource "azurerm_virtual_machine" "vm" {
  name                  = "vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Output the admin username and password
output "admin_username" {
  value = azurerm_virtual_machine.vm.os_profile[0].admin_username
}

output "admin_password" {
  value = azurerm_virtual_machine.vm.os_profile[0].admin_password
}

# Output the public IP address
output "public_ip" {
  value = azurerm_public_ip.publicip.ip_address
}

# Output the FQDN
output "fqdn" {
  value = azurerm_public_ip.publicip.fqdn
}

# Output the virtual machine ID
output "virtual_machine_id" {
  value = azurerm_virtual_machine.vm.id
}

# Output the virtual machine private IP address
output "private_ip_address" {
  value = azurerm_network_interface.nic.private_ip_address
}

variable "client_id" {
  description = "The client ID for the Service Principal"
}

variable "client_secret" {
  description = "The client secret for the Service Principal"
}

