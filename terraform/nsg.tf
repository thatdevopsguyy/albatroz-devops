# Create a Network Security Group (NSG) named "nsg_staging" for staging subnet with the following configuration:

resource "azurerm_network_security_group" "nsg_staging" {
  name                = var.stage_sg_name       # Name of the Network Security Group (NSG)
  location            = var.location            # Location/region for the NSG
  resource_group_name = var.resource_group_name # Name of the resource group where the NSG will be created
  tags                = local.tags_staging      # Tags to associate with the NSG

  dynamic "security_rule" {
    for_each = var.security_rules_staging
    content {
      name                       = security_rule.value.name                       # Name of the security rule
      priority                   = security_rule.value.priority                   # Priority of the security rule
      direction                  = security_rule.value.direction                  # Direction of the traffic (Inbound or Outbound)
      access                     = security_rule.value.access                     # Access control for the traffic (Allow or Deny)
      protocol                   = security_rule.value.protocol                   # Protocol for the traffic
      source_port_range          = security_rule.value.source_port_range          # Source port range for the traffic
      destination_port_ranges    = security_rule.value.destination_port_ranges    # Destination port ranges for the traffic
      source_address_prefix      = security_rule.value.source_address_prefix      # Source IP address prefix for the traffic
      destination_address_prefix = security_rule.value.destination_address_prefix # Destination IP address prefix for the traffic
    }
  }
}

# Create a Network Security Group (NSG) named "nsg_production" for production subnet with the following configuration:

resource "azurerm_network_security_group" "nsg_production" {
  name                = var.prod_sg_name        # Name of the Network Security Group (NSG)
  location            = var.location            # Location/region for the NSG
  resource_group_name = var.resource_group_name # Name of the resource group where the NSG will be created
  tags                = local.tags_production   # Tags to associate with the NSG

  dynamic "security_rule" {
    for_each = var.security_rules_production
    content {
      name                       = security_rule.value.name                       # Name of the security rule
      priority                   = security_rule.value.priority                   # Priority of the security rule
      direction                  = security_rule.value.direction                  # Direction of the traffic (Inbound or Outbound)
      access                     = security_rule.value.access                     # Access control for the traffic (Allow or Deny)
      protocol                   = security_rule.value.protocol                   # Protocol for the traffic
      source_port_range          = security_rule.value.source_port_range          # Source port range for the traffic
      destination_port_ranges    = security_rule.value.destination_port_ranges    # Destination port ranges for the traffic
      source_address_prefix      = security_rule.value.source_address_prefix      # Source IP address prefix for the traffic
      destination_address_prefix = security_rule.value.destination_address_prefix # Destination IP address prefix for the traffic
    }
  }
}
