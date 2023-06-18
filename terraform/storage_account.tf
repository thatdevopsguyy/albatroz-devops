# Create an Azure Storage Account named "sa" with the following configuration:

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name # Name of the Storage Account
  resource_group_name      = var.resource_group_name  # Name of the resource group where the Storage Account will be created
  location                 = var.location             # Location/region for the Storage Account
  account_tier             = "Standard"               # Tier of the Storage Account (Standard or Premium)
  account_replication_type = "GRS"                    # Replication type for the Storage Account (LRS, GRS, RAGRS, ZRS, etc.)
  tags                     = local.tags_default       # Tags to associate with the Storage Account
}

# Create a Storage Container named "sc_prod" under the previously created Storage Account:

resource "azurerm_storage_container" "sc_prod" {
  name                  = var.storage_container_name_prod # Name of the Storage Container
  storage_account_name  = azurerm_storage_account.sa.name # Name of the associated Storage Account
  container_access_type = "private"                       # Access type for the Storage Container (private, blob, container, or anonymous)
}

# Create a Storage Container named "sc_stage" under the previously created Storage Account:

resource "azurerm_storage_container" "sc_stage" {
  name                  = var.storage_container_name_stage # Name of the Storage Container
  storage_account_name  = azurerm_storage_account.sa.name  # Name of the associated Storage Account
  container_access_type = "private"                        # Access type for the Storage Container (private, blob, container, or anonymous)
}
