output "kubernetes_cluster_name" {
    value = module.my-aks.kubernetes_cluster_name
    }
output "k8s-version" {
    value = module.my-aks.latest_version
} 

output "acr_id" {
  value = module.my-aks.acr_id
}

output "acr_login_server" {
  value = module.my-aks.acr_login_server
}
output "azure_ad_group_id" {
  value = module.my-aks.azure_ad_group_id
}
output "azure_ad_group_objectid" {
  value = module.my-aks.azure_ad_group_objectid
}
