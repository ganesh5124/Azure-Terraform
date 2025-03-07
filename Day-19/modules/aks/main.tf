data "azurerm_kubernetes_service_versions" "current" {
  location        = var.location
  include_preview = false

}
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "prod-aks"
  location            = var.location
  resource_group_name = var.rgname
  dns_prefix          = "${var.rgname}-cluster"
  kubernetes_version  = coalesce(var.kubernetes_version, data.azurerm_kubernetes_service_versions.current.latest_version)
  node_resource_group = "${var.rgname}-node-rg"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    type       = "VirtualMachineScaleSets"
    node_labels = {
        "env" = "prod"

    }
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  linux_profile {
    admin_username = "aksuser"
    ssh_key {
      key_data = trimspace(file("~/.ssh/id_rsa.pub"))
    }
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }
}
