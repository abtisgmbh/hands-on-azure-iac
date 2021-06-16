rg=rg-docker-test
vm_name=docker-host
cloud_shell_ip=$(curl -s checkip.dyndns.org | sed -e 's/.*: //; s/<.*//')

az group create -n $rg -l westeurope

ip=$(az vm create \
--resource-group $rg \
--name $vm_name \
--image UbuntuLTS \
--admin-username azureuser \
--generate-ssh-keys \
--custom-data cloud-init-docker.yml \
--query "[publicIps]" \
--output tsv)

# Allow the current cloud shell to access the docker host
az network nsg rule create \
--access Allow \
--direction Inbound \
--name allow-docker-cloud-shell-2375 \
--nsg-name "${vm_name}NSG" \
--priority 101 \
--protocol Tcp \
--resource-group $rg \
--source-address-prefixes $cloud_shell_ip \
--destination-port-ranges 2375

export DOCKER_HOST=tcp://$ip:2375

# Test if everything is setup correctly
docker run --rm -it wernight/funbox cowsay "Hello CloudShell!"