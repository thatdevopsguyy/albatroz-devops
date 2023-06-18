# Create an Azure Container Registry (ACR) named "albatrozcr" with the following configuration:

resource "azurerm_container_registry" "acr" {
  name                = "albatrozcr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.tags_default
}
