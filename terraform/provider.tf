provider "azurerm" {
  features {}
  # subscription_id             = var.ARM_SUBSCRIPTION_ID
  # client_id                   = var.ARM_CLIENT_ID
  # client_secret               = var.ARM_CLIENT_SECRET
  # tenant_id                   = var.ARM_TENANT_ID
}


terraform {
  backend "azurerm" {
    resource_group_name  = "AlbatrozMGA"
    storage_account_name = "albatrozcicd"
    container_name       = "terraform"
    key                  = "albatroz-devops.tfstate"
  }
}
