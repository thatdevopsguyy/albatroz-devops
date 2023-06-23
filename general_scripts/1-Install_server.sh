#!/bin/bash

# Variables
RESOURCE_GROUP="AlbatrozMGA"
LOCATION="brazilsouth"
VNET_NAME="albatroz-infra"
ADDRESS_SPACE_1="10.1.0.0/16"
ADDRESS_SPACE_2="10.180.0.0/16"
SUBNET_NAME="infra-subnet"
SUBNET_PREFIX="10.180.1.0/24"
VM_SIZE="Standard_D2s_v3"
IMAGE="Ubuntu2204"
USERNAME="azureuser"
SUBSCRIPTION_ID="f08d58c6-4005-4b43-a95c-67ec23281878"
NSG_NAME="github-runner-nsg"
NSG_RULE_NAME="allow-ssh"
NSG_RULE_PRIORITY=100
IDENTITY_ROLE="Contributor" # Role to assign to the VM's Managed Identity
SERVICE_PRINCIPAL_NAME="terraform-githubaction" # Name of the service principal

# Prompt for VM name
read -p "Enter the name for the VM: " VM_NAME

# Generate SSH key pair
echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

# Check for the existence of the resource group
echo "Checking if resource group '$RESOURCE_GROUP' exists..."
GROUP_CHECK=$(az group exists --name $RESOURCE_GROUP)

if [ "$GROUP_CHECK" == "false" ]; then
    echo "Resource group '$RESOURCE_GROUP' does not exist. Creating..."
    az group create --name $RESOURCE_GROUP --location $LOCATION
else
    echo "Resource group '$RESOURCE_GROUP' already exists."
fi

# Check for the existence of the virtual network
echo "Checking if virtual network '$VNET_NAME' exists..."
VNET_CHECK=$(az network vnet show --resource-group $RESOURCE_GROUP --name $VNET_NAME --query "name" --output tsv)

if [ -z "$VNET_CHECK" ]; then
    echo "Virtual network '$VNET_NAME' does not exist. Creating..."
    az network vnet create --resource-group $RESOURCE_GROUP --name $VNET_NAME --address-prefixes $ADDRESS_SPACE_1 $ADDRESS_SPACE_2 --location $LOCATION
else
    echo "Virtual network '$VNET_NAME' already exists."
fi

# Check for the existence of the subnet
echo "Checking if subnet '$SUBNET_NAME' exists..."
SUBNET_CHECK=$(az network vnet subnet show --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --query "name" --output tsv)

if [ -z "$SUBNET_CHECK" ]; then
    echo "Subnet '$SUBNET_NAME' does not exist. Creating..."
    az network vnet subnet create --resource-group $RESOURCE_GROUP --vnet-name $VNET_NAME --name $SUBNET_NAME --address-prefix $SUBNET_PREFIX --location $LOCATION
else
    echo "Subnet '$SUBNET_NAME' already exists."
fi

# Create a public IP address
echo "Creating a public IP address..."
PUBLIC_IP_NAME="$VM_NAME-IP"
az network public-ip create --resource-group $RESOURCE_GROUP --name $PUBLIC_IP_NAME --sku Standard --location $LOCATION

# Create a network security group (NSG)
echo "Creating a network security group..."
az network nsg create --resource-group $RESOURCE_GROUP --name $NSG_NAME --location $LOCATION

# Add an inbound rule to allow SSH traffic
echo "Adding an inbound rule to the network security group..."
az network nsg rule create --resource-group $RESOURCE_GROUP --nsg-name $NSG_NAME --name $NSG_RULE_NAME --priority $NSG_RULE_PRIORITY --destination-port-ranges 22 --protocol Tcp --access Allow --direction Inbound

# Create a network interface
echo "Creating a network interface..."
NIC_NAME="$VM_NAME-NIC"
az network nic create --resource-group $RESOURCE_GROUP --name $NIC_NAME --location $LOCATION --subnet $SUBNET_NAME --vnet-name $VNET_NAME --public-ip-address $PUBLIC_IP_NAME --network-security-group $NSG_NAME

# Create a virtual machine
echo "Creating a virtual machine..."
az vm create --resource-group $RESOURCE_GROUP --name $VM_NAME --image $IMAGE --size $VM_SIZE --admin-username $USERNAME --ssh-key-value ~/.ssh/id_rsa.pub --nics $NIC_NAME --location $LOCATION --subscription $SUBSCRIPTION_ID

# Assign Managed Identity to the VM
echo "Assigning Managed Identity to the VM..."
az vm identity assign --resource-group $RESOURCE_GROUP --name $VM_NAME --role Contributor --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP


# Get the object ID of the service principal
echo "Retrieving the object ID of the service principal..."
SP_OBJECT_ID=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[0].appId" -o tsv)


# Get VM Resource ID
echo "Retrieving the object ID of the service principal..."
VM_RESOURCE_ID=$(az vm show --resource-group $RESOURCE_GROUP --name $VM_NAME --query id --out tsv)

# Assign the role to the service principal and VM scope
echo "Assigning the role to the service principal and to the VM Scope..."

az role assignment create --assignee $SP_OBJECT_ID --role Contributor --scope $VM_RESOURCE_ID

# Retrieve the public IP of the VM
echo "Retrieving the public IP of the VM..."
PUBLIC_IP=$(az network public-ip show --resource-group $RESOURCE_GROUP --name $PUBLIC_IP_NAME --query "ipAddress" --output tsv)
echo "The public IP of the VM is: $PUBLIC_IP"

# Copying scripts to the VM 
echo "Copying scripts to the VM..."

chmod +x *.sh && scp -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa *.sh $USERNAME@$PUBLIC_IP:/home/$USERNAME

# SSH to the VM
echo "SSH-ing to the VM..."
ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa $USERNAME@$PUBLIC_IP

