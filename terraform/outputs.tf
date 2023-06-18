output "vnet_id" {
  value       = azurerm_virtual_network.albatroz_nw.id
  description = "The ID of the virtual network"
}

output "subnet_staging_id" {
  value       = azurerm_subnet.subnet_staging.id
  description = "The ID of the staging subnet"
}

output "subnet_production_id" {
  value       = azurerm_subnet.subnet_production.id
  description = "The ID of the production subnet"
}

output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "The Login Server of the Container Registry."
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.sa.primary_access_key
  description = "The Primary Access Key for the Storage Account."
  sensitive   = true
}

output "storage_container_prod_id" {
  value       = azurerm_storage_container.sc_prod.id
  description = "The ID of the Storage Container."
}

output "storage_container_stage_id" {
  value       = azurerm_storage_container.sc_stage.id
  description = "The ID of the Storage Container."
}


output "vm_production_public_ip" {
  value       = azurerm_public_ip.prod_public_ip.ip_address
  description = "The Public IP Address of the Production VM."
}

output "vm_staging_public_ip" {
  value       = azurerm_public_ip.homolog_public_ip.ip_address
  description = "The Public IP Address of the Staging VM."
}


