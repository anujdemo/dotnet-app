








# Pre-requisited
- Validate that user has Contributor role in the associated subnets resource group.

# State
Terraform state is saved to a storage account "terraformstate80" in the "tfstatefiles" container.

# Adding new Clusters
- Copy and modify an environments tfvars file. The filename must match the cluster name.
- There is a node_pools array in the tfvars file that describes the settings for each nodepool.
  

# Documentation
- [azurerm_kubernetes_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster)
- [azurerm_kubernetes_cluster_node_pool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool)
