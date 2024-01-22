module "my-aks" {
    source = "./modules/aks"
    vnet_subnet_id = var.vnet_subnet_id
    kubernetes_version = var.kubernetes_version
    resource_group_name = var.resource_group_name
    location = var.location
    node_pools = var.node_pools
    vm_size = var.vm_size
    name = var.name
   
}
