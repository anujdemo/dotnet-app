resource_group_name     = "dev-aks"
location	            = "central india"
name                    = "DEVAKSMYORG"
node_count              = 3
kubernetes_version      = "1.25.6"
private_cluster_enabled = true
vnet_subnet_id          = "id"
node_pools = [
  {
    name                  = "npuserdc"
    vm_size               = "Standard_D8s_v5"
    mode                  = "User"
    enable_auto_scaling	= true
    min_count             = 1
    max_count             = 20
    node_count            = 1
    max_pods              = 50
    zones                 = ["1", "2", "3"]
  }
]
