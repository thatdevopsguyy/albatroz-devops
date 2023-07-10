# Create an Azure MySQL Flexible Server named "mysql_albatroz" with the following configuration:
resource "azurerm_mysql_flexible_server" "mysql_albatroz" {
  name                   = var.sql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  sku_name               = var.sql_server_compute_type
  administrator_login    = var.sql_administrator_login
  administrator_password = var.sql_server_admin_password
  backup_retention_days  = var.sql_server_backup_retention_days
  # delegated_subnet_id    = azurerm_subnet.subnet_production.id
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

# Private Endpoint for Mysql

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "allow_all" {
  name                        = "AllowAll"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  access                      = "Allow"
  priority                    = 100
  direction                   = "Inbound"
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.subnet_production.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_private_endpoint" "mysql_endpoint" {
  name                = "mysql_endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet_production.id

  private_service_connection {
    name                           = "mysql_psc"
    private_connection_resource_id = azurerm_mysql_flexible_server.mysql_albatroz.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
}
