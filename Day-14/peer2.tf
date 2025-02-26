resource "azurerm_virtual_network" "peer2vnet" {
  name                = "peer2vnet"
  address_space       = ["12.0.0.0/16"]
   location            = azurerm_resource_group.rg.location
   resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "peer2subnet" {
  name                 = "peer2subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.peer2vnet.name
  address_prefixes     = ["12.0.0.0/24"]
}

resource "azurerm_virtual_network_peering" "peer2vnet-peer" {
  name                         = "peer2vnet-peer"
  resource_group_name          = azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.peer2vnet.name
  remote_virtual_network_id    = azurerm_virtual_network.peer1vnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
    allow_gateway_transit        = true
    use_remote_gateways          = false
}

resource "azurerm_network_interface" "peer2nic" {
  name                = "peer2nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.peer2subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "peer2vm" {
  name                  = "peer2-vm"
  location              = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.peer2nic.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}