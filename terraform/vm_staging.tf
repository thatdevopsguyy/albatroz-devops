resource "azurerm_public_ip" "homolog_public_ip" {
  name                = var.stage_pub_ip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static" # Allocate a static public IP address
  tags                = local.tags_staging
}

resource "azurerm_network_interface" "vm_stage_nic" {
  name                = "${var.vm_stage_name}_nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags_staging

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet_staging.id
    private_ip_address_allocation = "Dynamic" # Allocate private IP dynamically
    public_ip_address_id          = azurerm_public_ip.homolog_public_ip.id
  }
}

resource "azurerm_virtual_machine" "vm_staging" {
  name                  = var.vm_stage_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_stage_nic.id]
  vm_size               = var.vm_size_staging
  tags                  = local.tags_staging

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = var.ubuntu_image
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_stage_name}_osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = var.vm_production_name
    admin_username = var.admin_username
    admin_password = var.admin_password # Specify the admin password for the virtual machine
  }

  os_profile_linux_config {
    disable_password_authentication = false # Enable password authentication
  }

  provisioner "remote-exec" {
    script = "${path.module}/install_docker.sh"

    connection {
      type        = "ssh"
      user        = var.admin_username
      password    = var.admin_password                             # Provide the admin password for SSH authentication
      host        = azurerm_public_ip.homolog_public_ip.ip_address # Get the IP address of the public IP
      agent       = false
      timeout     = "10m"
      script_path = "${path.module}/ssh_script_stage.sh"
    }
  }
}
