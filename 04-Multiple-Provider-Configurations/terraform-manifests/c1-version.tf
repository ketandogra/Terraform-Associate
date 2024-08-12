# Terraform Block
terraform {
  required_version = ">=1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Provider-1 for EastUS (Default Provider)

provider "azurerm" {
    features {
    } 
}


#Provider-2 for WestUS

provider "azurerm" {
    features { 
        virtual_machine {
            delete_os_disk_on_deletion = false
        } 
    }
    alias = "provider-2-westus"
    
}