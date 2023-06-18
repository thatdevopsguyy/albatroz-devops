# Create an Azure MySQL Server named "mysql_albatroz" with the following configuration:
resource "azurerm_mysql_server" "mysql_albatroz" {
  name                          = var.sql_server_name           # Name of the MySQL Server
  resource_group_name           = var.resource_group_name       # Name of the resource group where the MySQL Server will be created
  location                      = var.location                  # Location/region for the MySQL Server
  version                       = "8.0"                         # MySQL version
  administrator_login           = var.sql_administrator_login   # Administrator login for the MySQL Server
  administrator_login_password  = var.sql_server_admin_password # Administrator password for the MySQL Server
  sku_name                      = "GP_Gen5_2"                   # SKU name: General Purpose, Gen 5, 2 vCores
  storage_mb                    = 20480                         # Storage size in MB (20GB)
  backup_retention_days         = 7                             # Number of days of backups to retain
  geo_redundant_backup_enabled  = false                         # Enable geo-redundant backups if desired
  auto_grow_enabled             = false                         # Enable auto grow if desired
  public_network_access_enabled = true                          # Enable public network access if desired
  ssl_enforcement_enabled       = true                          # or false, depending on your preference
}

# Create an Azure MySQL Database named "albatroz_db" under the previously created MySQL Server:
resource "azurerm_mysql_database" "albatroz_db" {
  name                = var.database_name                        # Name of the MySQL Database
  resource_group_name = var.resource_group_name                  # Name of the resource group where the MySQL Database will be created
  server_name         = azurerm_mysql_server.mysql_albatroz.name # Name of the associated MySQL Server
  charset             = "utf8"                                   # Charset for the MySQL Database
  collation           = "utf8_unicode_ci"                        # Collation for the MySQL Database
}
