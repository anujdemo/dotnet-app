
# Microservices Architecture Design:
# Azure Kubernetes Service (AKS):

- Use AKS to orchestrate and manage the deployment of microservices. AKS provides a scalable, managed Kubernetes service.
# Microservices:
- Deploy each microservice as a separate containerized application within AKS.
- Use Docker containers for packaging each microservice to ensure consistency and isolation.
# Azure SQL Database:
- Host the database in Azure SQL Database, a fully managed relational database service.
- Configure the necessary databases and tables for the microservices.
# Communication:

- Enable secure communication between microservices and the SQL Database.
- Use Azure AD Managed Identity for authentication between AKS and Azure SQL Database.
# Ingress Controller:

- Use an Ingress controller for routing external HTTP/S traffic to the appropriate microservices.
- NGINX Ingress Controller is a common choice for AKS.
# Ingress Resource:

- Define an Ingress resource to specify routing rules for external access to microservices.
- Configure paths, rules, and backend services for each microservice.:

# Azure Key Vault:

- Store sensitive information, such as database connection strings and secrets, securely in Azure Key Vault.
- Access secrets securely from AKS using Azure AD Managed Identity.
# Architecture Diagram:
![aks](https://github.com/anujdemo/dotnet-app/assets/85152703/a5dd6142-9a1a-42d1-bcb8-beda2993d645)

# Discussion of Design Choices:
- Containerization: Using containers (Docker) allows each microservice to be isolated, making it easier to deploy, scale, and manage. It ensures consistency across development, testing, and production environments.

- Azure Kubernetes Service (AKS): AKS simplifies the deployment, scaling, and management of containerized applications. It also integrates with Azure AD for authentication and authorization.

- Azure SQL Database: Azure SQL Database is a fully managed relational database service, providing high availability, scalability, and security. It eliminates the need for manual database management tasks.

- Azure AD Managed Identity: Leveraging Managed Identity allows AKS to securely authenticate to Azure services like Azure SQL Database without storing credentials in configurations.

- Azure Key Vault: Centralizing the management of secrets in Key Vault enhances security. AKS can access secrets securely without the need to embed them in configuration files.

- Ingress Controller: NGINX Ingress Controller is a popular choice for routing external traffic to services within AKS. It provides features like load balancing, SSL termination, and routing rules.

- Ingress Resource: The Ingress resource defines routing rules for external HTTP/S traffic. It specifies how requests are directed to microservices based on paths, rules, and backend services.

# Considerations for Future Expansion:
- Logging and Monitoring: Implement logging and monitoring solutions for both microservices and the infrastructure to gain insights into application behavior and performance.

- Continuous Integration/Continuous Deployment (CI/CD): Implement CI/CD pipelines for automated deployment of microservices updates to AKS.

- Scaling: Consider implementing auto-scaling for AKS pods based on workload demands.

- Security: Regularly update and patch all components. Implement network policies and role-based access control (RBAC) to restrict access.

- Backup and Disaster Recovery: Configure regular backups for Azure SQL Database and implement a disaster recovery plan.





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
