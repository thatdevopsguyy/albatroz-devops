# Create an Azure Virtual Network named "albatroz_nw" with the following configuration:

resource "azurerm_virtual_network" "albatroz_nw" {
  name                = var.vnet_name           # Name of the virtual network
  location            = var.location            # Location/region for the virtual network
  resource_group_name = var.resource_group_name # Name of the resource group where the virtual network will be created
  address_space       = ["10.0.0.0/16"]         # Address space CIDR block for the virtual network
}


# Create a subnet named "subnet_staging" under the previously created virtual network:

resource "azurerm_subnet" "subnet_staging" {
  name                 = var.subnet_name_staging                  # Name of the subnet
  resource_group_name  = var.resource_group_name                  # Name of the resource group where the subnet will be created
  virtual_network_name = azurerm_virtual_network.albatroz_nw.name # Name of the associated virtual network
  address_prefixes     = ["10.0.1.0/24"]                          # CIDR block for the subnet
}


# Create a subnet named "subnet_production" under the previously created virtual network:

resource "azurerm_subnet" "subnet_production" {
  name                 = var.subnet_name_production               # Name of the subnet
  resource_group_name  = var.resource_group_name                  # Name of the resource group where the subnet will be created
  virtual_network_name = azurerm_virtual_network.albatroz_nw.name # Name of the associated virtual network
  address_prefixes     = ["10.0.2.0/24"]                          # CIDR block for the subnet
}
