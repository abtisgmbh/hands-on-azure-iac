#!/bin/bash
rgName='' # Name of the resource group the cloud shell is hosted in
location='westeurope'
vmName='mba-ubuntu-vm12345'
username='azureuser'

az vm create \
  --resource-group $rgName \
  --name $vmName \
  --image UbuntuLTS \
  --admin-username $username \
  --generate-ssh-keys \
  --tags lab=2

vmPublicIp=$(az vm show -d -g $rgName -n $vmName -o tsv --query "publicIps")
ssh $username@$vmPublicIp