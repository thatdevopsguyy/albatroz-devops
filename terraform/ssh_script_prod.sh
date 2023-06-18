#!/bin/bash
sshpass -p "${var.admin_password}" ssh -o StrictHostKeyChecking=no ${var.admin_username}@${azurerm_public_ip.prod_public_ip.ip_address} 'bash -s' < ${path.module}/install_docker.sh
