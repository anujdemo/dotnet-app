# Azure Location
variable "location" {
  type = string
  description = "Azure Region where all these resources will be provisioned"
  default = "Central US"
}

# Azure Resource Group Name
variable "resource_group_name" {
  type = string
  description = "This variable defines the Resource Group"
  default = "terraform-aks"
}

# Azure AKS Environment Name
variable "environment" {
  type = string  
  description = "This variable defines the Environment"  
  default = "dev"
}

variable "name" {
  type        = string
  default     = "PRDASSEVSAFEDCAKS"
  description = "Name of the AKS cluster."
  nullable    = false
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}
variable "vm_size" {
  type = string
  default = "Standard_B2s"
  
}

variable "msi_id" {
  type        = string
  description = "The Managed Service Identity ID. Set this value if you're running this example using Managed Identity as the authentication method."
  default     = null
}

variable "username" {
  type        = string
  description = "The admin username for the new cluster."
  default     = "azureadmin"
}

variable "kubernetes_version" {
  type        = string
  description = "The kubernetes version."
  default     = "1.25.6"
}

variable "vnet_subnet_id" {
  type        = string
  description = "The vnet subnet id."
  nullable    = true
}

variable "sku_tier" {
  type        = string
  description = "The SKU Tier that should be used for this Kubernetes Cluster."
  default     = "Free"
}

variable "private_cluster_enabled" {
  type        = bool
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?"
  default     = true
}

variable "node_pools" {
  type = list(object({
    name                   = string
    vm_size                = string
    mode                   = string
    enable_auto_scaling    = bool
    min_count              = number
    max_count              = number
    node_count             = number
    zones                  = list(string)
    max_pods               = number
  }))
}

variable "acr_name" {
  default = "devac899045678"
  
}