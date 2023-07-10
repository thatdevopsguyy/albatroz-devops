# Create an Azure MySQL Flexible Server named "mysql_albatroz" with the following configuration:
resource "azurerm_mysql_flexible_server" "mysql_albatroz" {
  name                   = var.sql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  sku_name               = var.sql_server_compute_type
  administrator_login    = var.sql_administrator_login
  administrator_password = var.sql_server_admin_password
  backup_retention_days  = var.sql_server_backup_retention_days
  delegated_subnet_id    = azurerm_subnet.subnet_production.id
  # public_network_access_enabled = true

  storage {
    size_gb           = var.sql_database_size
    iops              = "684"
    auto_grow_enabled = "true"
  }
}

# Create an Azure MySQL Database named "albatroz_db" under the previously created MySQL Flexible Server:
resource "azurerm_mysql_flexible_database" "albatroz_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql_albatroz.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
