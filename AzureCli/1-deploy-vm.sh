#!/bin/bash
rgName='rg-test'
location='westeurope'
vmName='myVM'

printf "\nCreating resource group: $rgName\n\n"
az group create -n $rgName -l $location


printf "\nCreating vm: $vmName\n\n"
az vm create \
  --resource-group $rgName \
  --name $vmName \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys
  
vmPublicIp=$(az vm list -d -g $rgName -o tsv --query "[].publicIps")

printf "\nConnect to vm on public ip: vmPublicIp\n\n"
ssh azureuser@$vmPublicIp
