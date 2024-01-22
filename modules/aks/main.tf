resource "random_string" "myrandom" {
  length = 6
  upper = false 
  special = false
  numeric = false   
}
resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = var.resource_group_name
}
# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  name                = "aks-network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/8"]
  depends_on = [ azurerm_resource_group.rg ]
}


# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = "aks-default-subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.240.0.0/16"]
  depends_on = [ azurerm_virtual_network.aksvnet ]
}

# Create Azure AD Group in Active Directory for AKS Admins
resource "azuread_group" "aks_administrators" {
  display_name = "${azurerm_resource_group.rg.name}-cluster-administrators"
  security_enabled = true
  description = "Azure AKS Kubernetes administrators for the ${azurerm_resource_group.rg.name}-cluster."
}
# Datasource to get Latest Azure AKS latest Version
data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.rg.location
  include_preview = false
}
resource "azurerm_kubernetes_cluster" "k8s" {
  name                    = var.name
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  private_cluster_enabled = var.private_cluster_enabled
  dns_prefix              = "${azurerm_resource_group.rg.name}-cluster"
  kubernetes_version      = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.rg.name}-nrg"
  sku_tier                = var.sku_tier
  
  identity {
    type = "SystemAssigned"
  }
  
  default_node_pool {
    name    		= "npsystem"
    vm_size  		= var.vm_size
    node_count		= var.node_count
    min_count  		= 2
    max_count  		= 4
    enable_auto_scaling = "true"
    vnet_subnet_id      = azurerm_subnet.aks-default.id
    zones               = ["1", "2", "3"]
  }
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }
  azure_active_directory_role_based_access_control {
  managed = true
  admin_group_object_ids = [azuread_group.aks_administrators.id]
}

  tags = {
    ProvisionedBy = "Terraform"
    
  }
  depends_on = [ azurerm_resource_group.rg,azurerm_virtual_network.aksvnet,azurerm_subnet.aks-default ]
}

resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  for_each = { for each in var.node_pools : each.name => each }
  #Implicit dependency from previous resource
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id

  #values from variable storage_config objects
  name                 = each.value.name
  vm_size              = each.value.vm_size
  mode                 = each.value.mode
  enable_auto_scaling  = each.value.enable_auto_scaling
  min_count            = each.value.min_count
  max_count            = each.value.max_count
  node_count           = each.value.node_count
  vnet_subnet_id       = azurerm_subnet.aks-default.id
  zones                = each.value.zones[*]
  max_pods             = each.value.max_pods

  #Apply tags
  tags = {
    ProvisionedBy = "Terraform"
    
  }
  
}
resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.k8s.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
  depends_on = [ azurerm_kubernetes_cluster.k8s ]
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.acr_name}-${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

