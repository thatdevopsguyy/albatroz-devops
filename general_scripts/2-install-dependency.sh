#!/bin/bash

RUNNER_VERSION="2.304.0"

# Update the repository and install necessary packages
sudo apt-get update
sudo apt-get install -y curl unzip jq

# Install Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Node.js
echo "Installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

# Get latest Terraform version
TERRAFORM_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')

# Install Terraform
echo "Installing Terraform..."
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Verify the installations
echo "Verifying installations..."
az --version
terraform --version
node --version
npm --version

# Az login 
echo " Az login "
# az login --use-device-code 
az login --identity


# Install GitHub Actions runner
# Create a folder

RUNNER_VERSION="2.304.0"

mkdir actions-runner && cd actions-runner

# Download the specific runner package
echo "Downloading GitHub Actions runner..."
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz


# Extract the runner package
echo "Extracting runner package..."
tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Configure Runner

# Prompt for repository URL
read -p "Enter the GitHub repository URL: " REPO_URL

# Prompt for token
echo "Please provide Github runner config Token"
echo "To get token to to your repo->settings->actions->runners->new-selfhostedrunner- find token in configure section(token is at ./config.sh at the end, ex : AG2C56OZOCVDHHCOJJ2JDEDERCKSM ) "
read  -p "Enter the token: " TOKEN
echo

# Install GitHub Actions runner
echo "Installing GitHub Actions runner..."
./config.sh --url "$REPO_URL" --token "$TOKEN" --unattended


# Create a service to keep the runner running
echo "Creating service..."
sudo ./svc.sh install

# Start the service
echo "Starting service..."
sudo ./svc.sh start

# Status  of the service
echo "Checking status of the  service..."
sudo ./svc.sh status


# Terraform user account auth 

az login --use-device-code 