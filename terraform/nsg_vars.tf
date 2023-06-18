variable "security_rules_staging" {
  description = "List of security rules for staging"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow_ssh"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["22"]
      source_address_prefix      = "20.195.202.231/32"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_http_https"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["80", "443"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_nodejs"
      priority                   = 1003
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["3025"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_mysql"
      priority                   = 1004
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["3306"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "security_rules_production" {
  description = "List of security rules for production"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow_ssh"
      priority                   = 1001
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["22"]
      source_address_prefix      = "20.195.202.231/32"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_http_https"
      priority                   = 1002
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["80", "443"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_mysql"
      priority                   = 1003
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["3306"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow_nodejs"
      priority                   = 1004
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["3000"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}


variable "stage_sg_name" {
  description = "NSG Stage"
  type        = string
  default     = "nsg-staging"
}


variable "prod_sg_name" {
  description = "NSG Prod"
  type        = string
  default     = "nsg-production"
}
