terraform {
  required_version = "~>1.5.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>3.0"
    }
  random ={
    source = "hashicorp/random"
    version = "~>3.0"
  }
  azuread ={
    source = "hashicorp/azuread"
    version = "~>2.0"
    }
  }  
  /*backend "azurerm" {
   storage_account_name = "terraformstate80"
   container_name       = "tfstatefiles"
   key = "qa.tfstate"
  }*/
}
provider "azurerm" {
  # Configuration options
     features {}

}     