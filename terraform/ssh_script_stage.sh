#!/bin/bash
sshpass -p "${TF_VAR_admin_password}" ssh -o StrictHostKeyChecking=no ${TF_VAR_admin_username}@${azurerm_public_ip.homolog_public_ip.ip_address} 'bash -s' < ${path.module}/install_docker.sh
