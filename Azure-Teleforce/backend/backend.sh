#!/bin/bash

# Configure remote backend for to store state file in azure storage account
# This script will create a storage account and container in azure and configure terraform backend to store state file in azure storage account

# Variables
RESOURCE_GROUP_NAME="state-file-rg"
STORAGE_ACCOUNT_NAME="statefilestorage$RANDOM"
CONTAINER_NAME="tfstate"
LOCATION="eastus"
action=$1

if [ "$action" == "delete" ]; then
    echo "Destroying resources..."
    # Destroy resources
    az group delete --name $RESOURCE_GROUP_NAME --yes
    exit 0
fi

if [ "$action" == "create" ]; then 
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION --sku Standard_LRS

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# Display storage account name and container name
echo "Storage account name: $STORAGE_ACCOUNT_NAME"
echo "Container name: $CONTAINER_NAME"

fi