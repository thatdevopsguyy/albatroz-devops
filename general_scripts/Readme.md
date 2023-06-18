## Albatroz Infrastructure Setup

This repository contains scripts for setting up the Albatroz infrastructure. Follow the steps below to clone the repository and execute the necessary scripts.

# Clone the Repository

# Setting Up SSH Key (For Private Repositories)

If the repository is private, you'll need to set up an SSH key to authenticate with GitHub. Follow the steps below to generate an SSH key and add it to your GitHub account:

- In the terminal or Azure Shell, generate an SSH key by running the following command:

`ssh-keygen -t rsa -b 4096`

Press Enter to accept the default file location and passphrase or provide your desired options.

- Once the key is generated, retrieve the content of the public key file (id_rsa.pub) by running the following command:

`cat ~/.ssh/id_rsa.pub`

- The output should display the content of your public key.

- Copy the entire content of the public key.

- Open your GitHub account in a web browser and go to "Settings".

- In the left sidebar, click on "SSH and GPG keys".

- Click on "New SSH key".

- Provide a suitable title for the key (e.g., "Azure Shell SSH Key").

- Paste the copied public key into the "Key" field.

- Click on "Add SSH key" to save the key to your GitHub account.

Now, you should be able to clone and access the private repository using SSH authentication.

# Clone the Repository

To clone this repository to your local machine or Azure Shell, follow these steps:

Open your terminal or Azure Shell.

Change to the directory where you want to clone the repository.

Run the following command to clone the repository:

` git clone [repository SSH ] `
 
That's it! You have successfully cloned the repository.

once cloned it run below commands

```
cd albatroz-infra/general_scripts
chmod +x *.sh
```
 # Public Repositories

```
git clone https://github.com/thatdevopsguyy/albatroz-devops
cd albatroz-devops/general_scripts
chmod +x *.sh

```

# Run the Installation Script

Execute the 1-Install_server.sh script to set up the server and the script will copy other required scripts to the newly created VM:

./1-Install_server.sh

Once the script finishes, you will be inside the newly created server.

# Install Dependencies

Inside the new server, run the following command to install the necessary dependencies:

./2-install-dependency.sh

This will install all the required dependencies for the Albatroz infrastructure.

That's it! You have successfully cloned the repository, executed the installation script, and installed the required dependencies. You are now ready to proceed with the Albatroz infrastructure setup.
# Set Up Secrets
Before running the scripts using GitHub Actions, you need to set up two secrets: `ADMIN_PASSWORD` and `SQL_SERVER_ADMIN_PASSWORD`. These secrets will be used during the infrastructure setup process.

To set up the secrets, follow these steps:

- Go to your repository on GitHub.
- Click on "Settings" at the top right corner of the repository page.
- In the left sidebar, click on "Secrets".
- Click on "New repository secret".
- Enter ADMIN_PASSWORD as the secret name and provide the corresponding value (the password for the admin user) in the "Value" field.
- Click on "Add secret" to save it.
- Repeat steps 4-6 to create the SQL_SERVER_ADMIN_PASSWORD secret.

## Azure VM Creation Script (1-Install_server.sh)

# Prerequisites
Before running the scripts, ensure that you have the following prerequisites in place:
* Azure subscription
* Azure CLI installed on your local machine or Azure Shell

# Script Usage

Follow the steps below to deploy and configure the VM using the provided scripts:

- Clone this repository to your local machine or Azure Shell using the following command:

`git clone [repository SSH or HTTPS URL]`

- Navigate to the repository directory:

`cd [repository directory]`

- Open the script file named `1-Install_server.sh` in a text editor.

Set the desired values for the variables at the top of the script file:

* `RESOURCE_GROUP`: The name of the Azure resource group to create.
* `LOCATION`: The Azure region where the resources will be deployed.
* `VNET_NAME`: The name of the virtual network to create.
* `ADDRESS_SPACE_1` and `ADDRESS_SPACE_2`: The address spaces for the virtual network.
* `SUBNET_NAME`: The name of the subnet to create within the virtual network.
* `SUBNET_PREFIX`: The subnet IP range.
* `VM_SIZE`: The size of the virtual machine.
* `IMAGE`: The VM image to use.
* `USERNAME`: The admin username for the VM.
* `SUBSCRIPTION_ID`: Your Azure subscription ID.
* `NSG_NAME`: The name of the network security group to create.
* `NSG_RULE_NAME`: The name of the inbound rule to allow SSH traffic.
* `NSG_RULE_PRIORITY`: The priority of the NSG rule.
* `IDENTITY_ROLE`: The role to assign to the VM's Managed Identity.
* `SERVICE_PRINCIPAL_NAME`: The name of the service principal.

- Save the script file after modifying the variables.

- Run the script using the following command:
`1-Install_server.sh`

- The script will prompt you to enter the name for the VM. Provide a suitable name and press Enter.

- The script will generate an SSH key pair, check the existence of the resource group, virtual network, and subnet, create necessary resources (public IP, NSG, NIC, VM), assign a Managed Identity to the VM, assign a role to the service principal, and retrieve the public IP of the VM.

- Once the script completes, it will copy the remaining scripts to the VM and establish an SSH connection to the VM.

- You can now execute further configuration steps or run additional scripts on the VM via the SSH connection.

Please ensure that you have the necessary permissions and credentials to deploy resources in Azure before running the script.

Note: Make sure to review the script and modify it according to your specific requirements before running it.

That's it! You can now deploy and configure a virtual machine in Azure using the provided scripts.
## Azure CI/CD Runner Setup Script(2-install-dependency.sh)

This script sets up an Azure CI/CD runner environment by installing necessary packages and tools.

## Prerequisites

- Ubuntu or Debian-based Linux distribution

## Usage

1. Run the script in a Bash environment.
2. The script will update the repository and install the necessary packages, including curl, unzip, and jq.
3. Azure CLI will be installed by running the installation script.
4. Node.js will be installed by adding the Node.js repository and installing it using apt-get.
5. The latest version of Terraform will be fetched from the HashiCorp API.
6. Terraform will be installed by downloading the appropriate version for Linux and moving it to the /usr/local/bin directory.
7. The installations of Azure CLI, Terraform, Node.js, and npm will be verified.
8. After executing the script, you should see the versions of each installed tool displayed.

**Note:** Make sure to run the script with appropriate permissions, as some commands require sudo access. It is also recommended to review the script and customize it according to your specific requirements before running it.

# GitHub Actions Runner Setup Script(3-configure-runner.sh)

This script sets up a GitHub Actions runner by downloading the runner package, configuring it, and creating a service to keep the runner running.

## Prerequisites

- Linux environment
- GitHub repository URL
- Runner token for the repository

## Usage

1. Create a folder to host the runner by running the following command:

2. Run the script in a Bash environment.

3. The script will prompt for the GitHub repository URL. Enter the URL when prompted.

4. The script will prompt for the runner token. Provide the token when prompted. You can find the token in your GitHub repository settings under Actions > Runners > New self-hosted runner > Configure.

5. The GitHub Actions runner package will be downloaded based on the specified runner version.

6. The runner package will be extracted.

7. The runner will be configured by running the `./config.sh` script with the provided repository URL and token.

8. A service will be created to keep the runner running.

9. The service will be started.

10. The status of the service will be checked to ensure that the runner is running.

**Note:** Make sure to run the script with appropriate permissions, as some commands may require sudo access. It is also recommended to review the script and customize it according to your specific requirements before running it.

