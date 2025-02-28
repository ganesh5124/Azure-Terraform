resource "azurerm_private_dns_zone" "prod_dns" {
  name                = "privatelink.eastus.azmk8s.io"
  resource_group_name = azurerm_resource_group.teleforce-prod.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "prod_dns_link" {
  name                  = "aks-dns-link"
  resource_group_name   = azurerm_resource_group.teleforce-prod.name
  private_dns_zone_name = azurerm_private_dns_zone.prod_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  resource_group_name = azurerm_resource_group.teleforce-prod.name
  location            = azurerm_resource_group.teleforce-prod.location
  dns_prefix          = var.dns_prefix
  role_based_access_control_enabled = true
  private_dns_zone_id = azurerm_private_dns_zone.prod_dns.id
  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.node_vm_size
    vnet_subnet_id = azurerm_subnet.private_subnets[0].id
    auto_scaling_enabled = true
    min_count  = var.min_node_count
    max_count  = var.max_node_count
  }
  # 
  identity {
    type = "SystemAssigned"
  }
  network_profile {
   network_plugin = "azure"  # Use Azure CNI for VNet integration
    network_policy = "azure" # Recommended for security
  }  
}

# resource "azurerm_log_analytics_workspace" "logs" {
#   name                = "${var.cluster_name}-logs"
#   location            = azurerm_resource_group.aks_rg.location
#   resource_group_name = azurerm_resource_group.aks_rg.name
#   sku                = "PerGB2018"
# }

# resource "azurerm_container_registry" "acr" {
#   name                = var.acr_name
#   resource_group_name = azurerm_resource_group.aks_rg.name
#   location            = azurerm_resource_group.aks_rg.location
#   sku                 = "Standard"
# }

# resource "azurerm_role_assignment" "acr_role" {
#   scope                = azurerm_container_registry.acr.id
#   role_definition_name = "AcrPull"
#   principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
# }

# User-Defined Route (UDR) for Private Outbound Traffic
resource "azurerm_route_table" "aks_route_table" {
  name                = "aks-udr"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "" "aks_internet_route" {
  name                   = "aks-internet-route"
  resource_group_name    = azurerm_resource_group.aks_rg.name
  route_table_name       = azurerm_route_table.aks_route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = "10.0.4.4"  # Replace with your firewall/NAT Gateway IP
}

resource "azurerm_subnet_route_table_association" "aks_subnet_udr" {
  subnet_id      = azurerm_subnet.aks_subnet_1.id
  route_table_id = azurerm_route_table.aks_route_table.id
}

# 7️⃣ NAT Gateway for Outbound Traffic
resource "azurerm_nat_gateway" "aks_nat" {
  name                = "aks-nat-gateway"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku_name            = "Standard"
}

resource "azurerm_subnet_nat_gateway_association" "aks_nat_assoc" {
  subnet_id      = azurerm_subnet.aks_subnet_1.id
  nat_gateway_id = azurerm_nat_gateway.aks_nat.id
}
