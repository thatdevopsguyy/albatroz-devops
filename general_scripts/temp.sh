# set the storage account name
devops_storage_account_name=albatrozcicd

# retrieve the storage account key from environment variable
devops_storage_account_key=${DEVOPS_STORAGE_ACCOUNT_KEY}

# set the name of the container
container_name=clientcerts

# set the expiry time in minutes
expiry_in_minutes=120

# calculate the expiry date
expiry=$(date -u -d "+${expiry_in_minutes} minutes" +%Y-%m-%dT%H:%MZ)

# function to download a blob and place it at a specified location
function download_blob {
  # take the blob name as an argument
  blob_name=$1

  # take the download path as an argument
  download_path=$2

  # generate the SAS token
  sas_token=$(az storage blob generate-sas \
    --account-name $devops_storage_account_name \
    --account-key $devops_storage_account_key \
    --name $blob_name \
    --container-name $container_name \
    --https-only \
    --permissions r \
    --expiry $expiry \
    --output tsv)

  # form the URL
  url="https://${devops_storage_account_name}.blob.core.windows.net/${container_name}/${blob_name}?${sas_token}"

  # download the file
  wget -O ${download_path} "${url}"
}

# download albatroz-client.pfx and place it under /home/azureuser/
download_blob "albatroz-client.pfx" "/home/azureuser/albatroz-client.pfx"

# backup existing .bashrc
cp /home/azureuser/.bashrc /home/azureuser/.bashrc.bak

# download .bashrc and overwrite /home/azureuser/.bashrc
download_blob "bashrc" "/home/azureuser/.bashrc"

# source the new .bashrc
source /home/azureuser/.bashrc
