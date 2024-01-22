variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
  nullable    = false
}

variable "location" {
  type        = string
  description = "Location of the resource group."
  nullable    = false
}
variable "acr_name" {
    default = "devacr899045678"
}
variable "name" {
  type        = string
  default     = "DEV-AKS"
  description = "Name of the AKS cluster."
  nullable    = false
}
variable "vm_size" {
  type = string
  default = "Standard_B2s"
}
variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool."
  default     = 3
}

variable "kubernetes_version" {
  type        = string
  description = "The kubernetes version."
  default     = "1.25.6"
}

variable "vnet_subnet_id" {
  type        = string
  description = "The vnet subnet id."
  nullable    = false
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