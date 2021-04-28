rg=rg-docker-test
vmName=docker-host


ip=$(az vm create \ 
--resource-group $rg \
--name $vmName \
--image UbuntuLTS \
--admin-username azureuser \
--generate-ssh-keys \
--custom-data cloud-init-docker.txt \
--query "[publicIps]" \
--output tsv)

export DOCKER_HOST=tcp://$ip:2375

