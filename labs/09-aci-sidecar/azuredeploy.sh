rg=rg-container-test

source ./code-server-caddy.env
envsubst < code-server-caddy.template.yaml > code-server-caddy.yaml

az group create --name $rg --location westeurope
az container create --resource-group $rg --file code-server-caddy.yaml