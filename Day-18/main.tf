resource "azurerm_resource_group" "provisioners-rg" {
  name     = var.resource_group_name
  location = var.location
}

#################### Virtual Network ########################
resource "azurerm_virtual_network" "provisioners-vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.provisioners-rg.name
  location            = azurerm_resource_group.provisioners-rg.location
  address_space       = ["10.0.0.0/16"]
}

#################### Subnet ########################
resource "azurerm_subnet" "provisioners-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.provisioners-rg.name
  virtual_network_name = azurerm_virtual_network.provisioners-vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#################### Network Security Group ########################
resource "azurerm_network_security_group" "provisioners-nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.provisioners-rg.location
  resource_group_name = azurerm_resource_group.provisioners-rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#################### Public IP ########################
resource "azurerm_public_ip" "provisioners-pip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.provisioners-rg.location
  resource_group_name = azurerm_resource_group.provisioners-rg.name
  allocation_method   = var.allocation_method
}

#################### Network Interface ########################
resource "azurerm_network_interface" "provisioners-nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.provisioners-rg.location
  resource_group_name = azurerm_resource_group.provisioners-rg.name

  ip_configuration {
    name                          = "provisioners-nic-ip"
    subnet_id                     = azurerm_subnet.provisioners-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.provisioners-pip.id
  }
}

#################### NSG to Public IP Association ########################

resource "azurerm_network_interface_security_group_association" "provisioners-nsg-association" {
  network_interface_id      = azurerm_network_interface.provisioners-nic.id
  network_security_group_id = azurerm_network_security_group.provisioners-nsg.id
}

#################### NSG to Subnet Association ########################

# resource "azurerm_subnet_network_security_group_association" "provisioners-nsg-association" {
#   subnet_id                 = azurerm_subnet.provisioners-subnet.id
#   network_security_group_id = azurerm_network_security_group.provisioners-nsg.id
# }

#################### VM ########################
resource "azurerm_linux_virtual_machine" "provisioners-vm" {
  name                = "provisioners-vm"
  resource_group_name = azurerm_resource_group.provisioners-rg.name
  location            = azurerm_resource_group.provisioners-rg.location
  size                = "Standard_B1s"

  computer_name                   = "provisioners-vm"
  admin_username                  = "azureuser"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.provisioners-nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  depends_on = [ null_resource.deployment-prep ]

    provisioner "remote-exec" {
    connection {
        type     = "ssh"
        user        = "azureuser"
        private_key = file("~/.ssh/id_rsa")
        host = azurerm_public_ip.provisioners-pip.ip_address
    }
        inline = [
        "sudo apt-get update",
        "sudo apt-get install -y nginx",
        ## create sample index.html file
        "echo '<h1>Hello, World!</h1>' | sudo tee /var/www/html/index.html",
        "sudo systemctl start nginx",
        "sudo systemctl enable nginx"
        ]
    }

    provisioner "file" {
    source      = "configs/sample.conf"
    destination = "/home/azureuser/sample.conf"
    connection {
        type     = "ssh"
        user        = "azureuser"
        private_key = file("~/.ssh/id_rsa")
        host = azurerm_public_ip.provisioners-pip.ip_address
    }
    }

}

resource "null_resource" "deployment-prep" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'Deployment started at: ${timestamp()}' > deployment-${timestamp()}.log"
  }
}

output "public_ip" {
  value = azurerm_public_ip.provisioners-pip.ip_address
}
