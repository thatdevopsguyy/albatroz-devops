variable "resource_group_name" {
  description = "Name of the Resource Group"
  default     = "AlbatrozMGA"
}

variable "location" {
  description = "The Azure region where the resources will be deployed"
  type        = string
  default     = "brazilsouth" # Replace with the desired Azure region
}

variable "ubuntu_image" {
  description = "Ubuntu Server Image"
  default     = "UbuntuLTS"
}

variable "vm_production_name" {
  description = "Prod VM name"
  default     = "albatroz-production"
}

variable "vm_stage_name" {
  description = "Prod VM name"
  default     = "albatroz-homolog"
}


variable "vm_size_staging" {
  description = "VM Size for Staging"
  default     = "Standard_B2s"
}

variable "vm_size_production" {
  description = "VM Size for Production"
  default     = "Standard_B2ms"
}

variable "storage_account_tier" {
  description = "Storage Account Tier"
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage Account Replication Type"
  default     = "GRS"
}

variable "vnet_name" {
  description = "VNet Name"
  default     = "albatroz-subnet"
}

variable "subnet_name_staging" {
  description = "Subnet Name for Staging"
  default     = "albatroz-dev"
}

variable "subnet_name_production" {
  description = "Subnet Name for Production"
  default     = "albatroz-prod"
}

#variable "startup_script_path" {
#  description = "Path to the startup script"
#}

variable "storage_container_name_prod" {
  description = "Storage Container name"
}

variable "storage_container_name_stage" {
  description = "Storage Container name"
}

variable "storage_account_name" {
  description = "Storage Account name"
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
  default     = "albatroz-prod-mysql"
}

variable "sql_server_admin_password" {
  description = "Password for the SQL Server"
  type        = string
}


variable "sql_administrator_login" {
  description = "The  admin name of the SQL Server"
  type        = string
}


variable "database_name" {
  description = "The name of the database"
  type        = string
  default     = "albatrozprod"
}

variable "security_group_name" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "albatroz-prod-nsg"
}

variable "admin_username" {
  description = "The username of the admin account"
}

variable "admin_password" {
  description = "The password of the admin account"
}

# variable "subscription_id" {
#   description = "Azure Subscription ID"
#   type        = string
# }


variable "container_registry_name" {
  description = "Name Of The Container Registry"
  default     = "albatrozcr"
}

variable "sql_server_version" {
  description = "Version of Sql Server"
  default     = "8.0"
}

variable "sql_database_size" {
  description = "max_size_gb of Sql Server"
  default     = "128"
}

variable "sql_server_compute_type" {
  description = "Size of  MySql Server"
  default     = "Standard_D2s_v3"
}

variable "sql_server_backup_retention_days" {
  description = "No of Days for MySql Server Backup Retention"
  default     = "7"
}

variable "ssl_enforcement_enabled" {
  description = "Enable SSL enforcement"
  type        = bool
  default     = false
}

variable "stage_pub_ip" {
  description = "The Public ip of Staging Server"
  type        = string
  default     = "albatroz-homolog-pub-ip"
}


variable "prod_pub_ip" {
  description = "The Public ip of Production Server"
  type        = string
  default     = "albatroz-production-pub-ip"
}

