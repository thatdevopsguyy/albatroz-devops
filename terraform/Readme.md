### Prerequisites

Before you begin, ensure you have the following:

* Azure subscription
* Terraform installed on your local machine
* Azure CLI credentials configured


## Azure Virtual Network and Subnets(network.tf)

This file contains Terraform code to create an Azure Virtual Network and two subnets, named "subnet_staging" and "subnet_production". The configuration for the Virtual Network and subnets is described below.

# Usage

Follow the steps below to create the Azure Virtual Network and subnets:

* Clone this repository to your local machine or download the code as a zip file.
* Open a terminal or command prompt and navigate to the project directory.
* Set the required variables in a terraform.tfvars file or through environment variables. The variables you need to set are:
   - `vnet_name`: Name of the virtual network.
   - `location`: Location/region for the virtual network.
   - `resource_group_name`: Name of the resource group where the virtual network will be created.
   - `subnet_name_staging`: Name of the staging subnet.
   - `subnet_name_production`: Name of the production subnet.
* Initialize the Terraform project by running terraform init command.
* Preview the resources that will be created by running terraform plan command.
* Deploy the resources by running terraform apply command.
* Confirm the deployment by typing yes when prompted.
* Terraform will create the Azure Virtual Network and subnets based on the provided configuration.
* After the deployment is complete, you can view the created resources in the Azure portal.

# Configuration
 The Terraform code creates the following resources in Azure:

# Azure Virtual Network

The Azure Virtual Network is created using the following configuration:

```hcl
resource "azurerm_virtual_network" "albatroz_nw" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}
```
  - `name`: The name of the virtual network.
  - `location`: The location or region where the virtual network will be created.
  - `resource_group_name`: The name of the resource group where the virtual network will be created.
  - `address_space`: The CIDR block for the virtual network.

# Subnet: "subnet_staging"
  The subnet named "subnet_staging" is created using the following configuration:

```hcl
resource "azurerm_subnet" "subnet_staging" {
  name                 = var.subnet_name_staging
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.albatroz_nw.name
  address_prefixes     = ["10.0.1.0/24"]
}
```

 - `name`: The name of the subnet.
 - `resource_group_name`: The name of the resource group where the subnet will be created.
 - `virtual_network_name`: The name of the associated virtual network.
 - `address_prefixes`: The CIDR block for the subnet

# Subnet: "subnet_production" 
  The subnet named "subnet_production" is created using the following configuration:
```hcl
  resource "azurerm_subnet" "subnet_production" {
  name                 = var.subnet_name_production
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.albatroz_nw.name
  address_prefixes     = ["10.0.2.0/24"]
}
```
 -  `name`: The name of the subnet.
 -  `resource_group_name`: The name of the resource group where the subnet will be created.
 -  `virtual_network_name`: The name of the associated virtual network.
 -  `address_prefixes`: The CIDR block for the subnet

## Network Security Groups (NSGs) for Staging and Production Subnets(nsg.tf)

This file contains Terraform code to create Network Security Groups (NSGs) for the staging and production subnets. The NSGs are named "nsg_staging" and "nsg_production" respectively, and have the following configurations.

# Usage

Follow the steps below to create the NSGs for the staging and production subnets:

* Clone this repository to your local machine or download the code as a zip file.
* Open a terminal or command prompt and navigate to the project directory.
* Set the required variables in a terraform.tfvars file or through environment variables. The variables you need to set are:
  - `stage_sg_name`: Name of the Network Security Group for the staging subnet.
  - `prod_sg_name`: Name of the Network Security Group for the production subnet.
  - `location`: Location/region for the NSGs.
  - `resource_group_name`: Name of the resource group where the NSGs will be created.
  - `security_rules_staging`: Configuration for the security rules of the staging NSG.
  - `security_rules_production`: Configuration for the security rules of the production NSG.
* Initialize the Terraform project by running terraform init command.
* Preview the resources that will be created by running terraform plan command.
* Confirm the deployment by typing yes when prompted.
* Terraform will create the NSGs and associate the security 
* rules based on the provided configurations.
* After the deployment is complete, you can view the created NSGs in the Azure portal.

# Configuration

The Terraform code creates the following resources in Azure:

# Network Security Group (NSG) for Staging Subnet

The NSG for the staging subnet is created using the following configuration:

```hcl
resource "azurerm_network_security_group" "nsg_staging" {
  name                = var.stage_sg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags_staging

  dynamic "security_rule" {
    for_each = var.security_rules_staging
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_ranges    = security_rule.value.destination_port_ranges
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
```
- `name`: The name of the NSG for the staging subnet.
- `location`: The location or region where the NSG will be created.
- `resource_group_name`: The name of the resource group where the NSG will be created.
- `tags`: Tags to associate with the NSG.
- `security_rule`: The dynamic block for defining the security rules of the NSG.

# Network Security Group (NSG) for Production Subnet

The NSG for the production subnet is created using the following configuration:

```hcl
resource "azurerm_network_security_group" "nsg_production" {
  name                = var.prod_sg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags_production

  dynamic "security_rule" {
    for_each = var.security_rules_production
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_ranges    = security_rule.value.destination_port_ranges
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}
```


## Azure Container Registry (ACR) Setup for Albatroz(container_registry.tf)

This file contains Terraform configuration to setup an Azure Container Registry (ACR) named "albatrozcr".

# ACR Configuration

The configuration creates an ACR with the following settings:

- `name`: The name of the Azure Container Registry. It is set to "albatrozcr".
- `resource_group_name`: The name of the resource group in which the ACR will be created. It is determined by the `resource_group_name` variable.
- `location`: The location/region where the ACR will be created. It is determined by the `location` variable.
- `sku`: The pricing tier for the ACR. It is set to "Basic", but can be changed to "Standard" or "Premium" as per requirements.
- `admin_enabled`: Admin access to the ACR is enabled by setting this to `true`.
- `tags`: The tags associated with the ACR, determined by `local.tags_default`.

Here is the Terraform configuration block:

```hcl
resource "azurerm_container_registry" "acr" {
  name                = "albatrozcr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.tags_default
}
```

## Azure MySQL Server and Database Setup for Albatroz(mysql-prod.tf)

This file contains Terraform configuration to setup an Azure MySQL Server named "mysql_albatroz" and a MySQL Database named "albatroz_db".

# Azure MySQL Server Configuration

The configuration creates a MySQL Server with the following settings:

- `name`: The name of the MySQL Server. It is determined by the `sql_server_name` variable.
- `resource_group_name`: The name of the resource group in which the MySQL Server will be created. It is determined by the `resource_group_name` variable.
- `location`: The location/region where the MySQL Server will be created. It is determined by the `location` variable.
- `version`: The MySQL version. It is set to "8.0".
- `administrator_login`: Administrator login for the MySQL Server. It is determined by the `sql_administrator_login` variable.
- `administrator_login_password`: Administrator password for the MySQL Server. It is determined by the `sql_server_admin_password` variable.
- `sku_name`: SKU name for the MySQL Server. It is set to "GP_Gen5_2" representing General Purpose, Gen 5, 2 vCores.
- `storage_mb`: Storage size in MB. It is set to 20480 (20GB).
- `backup_retention_days`: Number of days of backups to retain. It is set to 7 days.
- `geo_redundant_backup_enabled`: Geo-redundant backups are disabled in this configuration.
- `auto_grow_enabled`: Auto grow is disabled in this configuration.
- `public_network_access_enabled`: Public network access is enabled in this configuration.
- `ssl_enforcement_enabled`: SSL enforcement is enabled in this configuration.

Here is the Terraform configuration block:

```hcl
resource "azurerm_mysql_server" "mysql_albatroz" {
  name                          = var.sql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "8.0"
  administrator_login           = var.sql_administrator_login
  administrator_login_password  = var.sql_server_admin_password
  sku_name                      = "GP_Gen5_2"
  storage_mb                    = 20480
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  auto_grow_enabled             = false
  public_network_access_enabled = true
  ssl_enforcement_enabled       = true
}
```

# Azure MySQL Database Configuration

The configuration creates a MySQL Database with the following settings:

- `name`: The name of the MySQL Database. It is determined by the database_name variable.
- `resource_group_name`: The name of the resource group in which the MySQL Database will be created. It is determined by the resource_group_name variable.
- `server_name`: The name of the MySQL Server that the database will be associated with. It is set to the name of the previously created MySQL Server "mysql_albatroz".
- `charset`: The charset for the MySQL Database. It is set to "utf8".
- `collation`: The collation for the MySQL Database. It is set to "utf8_unicode_ci".

Here is the Terraform configuration block:

```hcl
resource "azurerm_mysql_database" "albatroz_db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql_albatroz.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
```

## Azure Storage Account and Containers (storage_account.tf)

This file contains Terraform code to create an Azure Storage Account and two storage containers. The Storage Account is named "sa" and the storage containers are named "sc_prod" and "sc_stage" respectively. The configurations for the Storage Account and storage containers are described below.


# Usage

Follow the steps below to create the Azure Storage Account and storage containers:

* Clone this repository to your local machine or download the code as a zip file.
* Open a terminal or command prompt and navigate to the project directory.
* Set the required variables in a terraform.tfvars file or through environment variables. The variables you need to set are:
  - `storage_account_name`: Name of the Storage Account.
  - `resource_group_name`: Name of the resource group where the Storage Account will be created.
  - `location`: Location/region for the Storage Account.
  - `storage_container_name_prod`: Name of the production storage container.
  - `storage_container_name_stage`: Name of the staging storage container.
* Initialize the Terraform project by running terraform init command.
* Preview the resources that will be created by running terraform plan command.
* Deploy the resources by running terraform apply command.
* Confirm the deployment by typing yes when prompted.
* Terraform will create the Azure Storage Account and storage containers based on the provided configuration.
* After the deployment is complete, you can view the created resources in the Azure portal.

# Configuration
The Terraform code creates the following resources in Azure:

# Azure Storage Account

The Azure Storage Account is created using the following configuration:

```hcl
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags                     = local.tags_default
}
```
- `name`: The name of the Storage Account.
- `resource_group_name`: The name of the resource group where the Storage Account will be created.
- `location`: The location or region where the Storage Account will be created.
- `account_tier`: The tier of the Storage Account (Standard or Premium).
- `account_replication_type`: The replication type for the Storage Account (LRS, GRS, RAGRS, ZRS, etc.).
- `tags`: Tags to associate with the Storage Account.

# Storage Containers

Two storage containers are created under the previously created Storage Account: "sc_prod" and "sc_stage". The configurations for the storage containers are as follows:

```hcl
resource "azurerm_storage_container" "sc_prod" {
  name                  = var.storage_container_name_prod
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "sc_stage" {
  name                  = var.storage_container_name_stage
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
```

- `name`: The name of the storage container.
- `storage_account_name`: The name of the associated Storage Account.
- `container_access_type`: The access type for the storage container (private, blob, container, or anonymous).


## Azure Virtual Machine and Networking(vm_production.tf,vm_staging.tf)

This file contains Terraform code to create an Azure Virtual Machine (VM) and associated networking resources. The VM is named "vm_production" and is configured with a public IP address, network interface, and storage settings. The configurations for the VM and networking resources are described below.

# Usage

Follow the steps below to create the Azure Virtual Machine and associated networking resources:

* Clone this repository to your local machine or download the code as a zip file.
* Open a terminal or command prompt and navigate to the project directory.
* Set the required variables in a terraform.tfvars file or through environment variables. The variables you need to set are:

 - `prod_pub_ip`: Name of the public IP address for the VM.
 - `location`: Location/region for the VM and networking resources.
 - `resource_group_name`: Name of the resource group where the VM and resources will be created.
 - `vm_production_name`: Name of the production VM.
 - `vm_size_production`: Size of the VM (e.g., Standard_DS2_v2).
 - `ubuntu_image`: Ubuntu image SKU for the VM.
 - `admin_username`: Admin username for the VM.
 - `admin_password`: Admin password for the VM.
* Initialize the Terraform project by running terraform init command.
* Preview the resources that will be created by running terraform plan command.
* Deploy the resources by running terraform apply command.
* Confirm the deployment by typing yes when prompted.
* Terraform will create the Azure VM and associated networking 
* resources based on the provided configuration.
* After the deployment is complete, you can access the VM using the provided public IP address.

# Configuration
The Terraform code creates the following resources in Azure:
# Public IP Address
The public IP address is created using the following configuration:

```hcl
resource "azurerm_public_ip" "prod_public_ip" {
  name                = var.prod_pub_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  tags                = local.tags_production
}
```

- `name`: The name of the public IP address for the VM.
- `location`: The location or region where the public IP address will be created.
- `resource_group_name`: The name of the resource group where the public IP address will be created.
- `allocation_method`: The allocation method for the public IP address (Static or Dynamic).
- `tags`: Tags to associate with the public IP address.

# Network Interface
The network interface is created using the following configuration:

```hcl
resource "azurerm_network_interface" "vm_production_nic" {
  name                = "${var.vm_production_name}_nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags_production

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet_production.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.prod_public_ip.id
  }
}
```

- `name`: The name of the network interface for the VM.
- `location`: The location or region where the network interface will be created.
- `resource_group_name`: The name of the resource group where the network interface will be created.
- `tags`: Tags to associate with the network interface.
- `ip_configuration`: The block for configuring the IP configuration of the network interface, including the subnet and associated public IP address.

# Virtual Machine

The virtual machine is created using the following configuration:

```hcl
resource "azurerm_virtual_machine" "vm_production" {
  name                  = var.vm_production_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_production_nic.id]
  vm_size               = var.vm_size_production
  tags                  = local.tags_production

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = var.ubuntu_image
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_production_name}_osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_production_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  provisioner "remote-exec" {
    script = "${path.module}/install_docker.sh"

    connection {
      type        = "ssh"
      user        = var.admin_username
      password    = var.admin_password
      host        = azurerm_public_ip.prod_public_ip.ip_address
      agent       = false
      timeout     = "10m"
      script_path = "${path.module}/ssh_script_prod.sh"
    }
  }
}
```

- `name`: The name of the virtual machine.
- `location`: The location or region where the virtual machine will be created.
- `resource_group_name`: The name of the resource group where the virtual machine will be created.
- `network_interface_ids`: The IDs of the network interfaces associated with the virtual machine.
- `vm_size`: The size of the virtual machine.
- `tags`: Tags to associate with the virtual machine.
- `delete_os_disk_on_termination`: Whether to delete the OS disk when the virtual machine is terminated.
- `delete_data_disks_on_termination`: Whether to delete the data disks when the virtual machine is terminated.
- `storage_image_reference`: The reference to the OS image for the virtual machine.
- `storage_os_disk`: The configuration for the OS disk of the virtual machine.
- `os_profile`: The OS profile configuration for the virtual machine.
- `os_profile_linux_config`: The configuration for the Linux OS profile.
- `provisioner`: The provisioner block for executing remote commands on the virtual machine.

**The only change in Stage and Prod VM is the instance type**

## Bash Script for Docker and Docker Compose Installation on VM (install_docker.sh)

This repository contains a bash script that installs Docker and Docker Compose on an Ubuntu machine. The script performs the following actions:

* Updates the package list by running sudo apt-get update.
* Installs necessary dependencies for package management by running sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common.
* Adds the Docker repository GPG key by running curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -.
* Adds the Docker repository to the package sources by running sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable".
* Updates the package list again to include the Docker packages by running sudo apt-get update.
* Installs Docker Community Edition (CE) by running sudo apt-get install -y docker-ce.
* Adds the current user to the docker group for running Docker commands without sudo by running sudo usermod -aG docker ${USER}.
* Installs Docker Compose by downloading the binary and making it executable:
Downloads the Docker Compose binary by running sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose.
* Makes the downloaded binary executable by running sudo chmod +x /usr/local/bin/docker-compose.

