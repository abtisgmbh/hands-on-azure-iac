#!/bin/bash
rgName='rg-azurecli-test'
location='westeurope'
vmName='mylinuxVm'
username='azureuser'

printf "\nCreating resource group: $rgName\n\n"
az group create -n $rgName -l $location


printf "\nCreating vm: $vmName\n\n"
az vm create \
  --resource-group $rgName \
  --name $vmName \
  --image UbuntuLTS \
  --admin-username $username \
  --generate-ssh-keys
  
vmPublicIp=$(az vm list -d -g $rgName -o tsv --query "[].publicIps")

printf "\nConnect to vm: ssh $username@$vmPublicIp\n\n"
