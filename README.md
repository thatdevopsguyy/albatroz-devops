# Albatroz Infrastructure

This repository contains the Infrastructure as Code (IaC) configuration for the Albatroz project using Terraform and Azure. It uses GitHub Actions for automating the Terraform workflows.

## Directory Structure

- `.github/workflows`: This directory contains GitHub Actions workflow files for automating Terraform tasks.
- `terraform`: This directory contains the Terraform configuration files.

## Workflows

- `Terraform Destroy` (`tf-destroy.yml`): A workflow that's manually triggered to tear down the infrastructure.
- `Terraform Plan/Apply` (`tf-plan-apply.yml`): A workflow that's triggered manually, on push to the main branch, or on a pull request to the main branch. It contains two jobs: 'Terraform Plan' and 'Terraform Apply'.

Both workflows use Azure and Terraform specific environment variables set in the GitHub secrets. The workflows run on a self-hosted runner, checkout the repository, setup Terraform, and run `terraform init` in the `terraform` directory.

## Terraform Configuration

The Terraform configuration is contained within the `terraform` directory. (Detailed information about the Terraform configuration would go here, but the contents couldn't be inspected due to technical limitations.)


# Prereqesites for Terraform backend.

For terraform backend we are using the azure storage.we need to set it up manully for the first time and add necessary terraform configuration.

To manually create the Terraform state file in the Azure console, you can follow these steps:

- Open the Azure portal and navigate to the Azure Storage Account that you want to use for storing the state file (`albatrozcicd` in this case). 

- Inside the Storage Account, navigate to the Blob service and locate the container named `terraform`. If the container does not exist, create it. you can create your own container

- Within the terraform container, create a new blob named albatroz-devops.tfstate.

- Now, update your Terraform configuration file (provider.tf) to include the backend configuration for Azure. Replace the existing terraform block with the following code:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "AlbatrozMGA"
    storage_account_name = "albatrozcicd"
    container_name       = "terraform"
    key                  = "albatroz-devops.tfstate"
  }
}
```
- Save the updated configuration file.

- Now, when you run Terraform commands, it will use the Azure Storage Account specified in the backend configuration to store and manage the state file (albatroz-devops.tfstate).
