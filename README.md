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


