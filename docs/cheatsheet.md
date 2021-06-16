
## Azure CloudShell

### Get token for Azure API from Cloud Shell session


```bash
accessToken="Bearer $(curl http://localhost:50342/oauth2/token \
  --data "resource=https://management.azure.com/" \
  -H Metadata:true -s | jq -r '.access_token')"

# User settings abrufen
curl https://management.azure.com/providers/Microsoft.Portal/usersettings/cloudconsole?api-version=2017-12-01-preview -H Authorization:"$accessToken" -s | jq
```

### Run CloudShell in docker container

```bash
docker pull mcr.microsoft.com/azure-cloudshell:latest

docker run -it \
  --mount type=bind,source=$(pwd)/cloudshell,target=/usr/cloudshell/cloudshell \
  mcr.microsoft.com/azure-cloudshell \
  /bin/bash
```

### Use POSIX tooks in PowerShell

```powershell
gci | awk '$5 {print $5}'
(gci).Name
```

### List all available PowerShell modules

```powershell
gmo -ListAvailable
```

### Use SHiPS in PowerShell to navigate azure resources

```powershell
$someResources = dir Azure: -r | select -First 100
$someResources | Select Name,ResourceGroupName,Location,ResourceType
```

### Use interactive GridView in PowerShell

```powershell
Find-Module -Command Out-ConsoleGridView | Install-Module

dir | Out-ConsoleGridView | Select Name,LastWrite
```

### Run single PowerShell command from bash

```bash
pwsh -noni -nop -c 'gci | % { "I see $($_.Name)"  }'
```

### Configure OhMyZsh in CloudShell

```bash
cd hands-on-azure-iac/CloudShell/zsh
./configure.sh
```

## Azure CLI

### Hilfe verwenden

```bash
az --help   
```

### Beispiele finden

```bash
az find "get storage account key"
```

### Output formatieren

```
az storage account list -g rg-mba-cloudshell -o table
```

### Zeilenumbruch kontrollieren

```bash
tput rmam # Remove automatic margins

tput smam # Set automatic margins
```

### Ausgaben mit JMESPATH queries filtern

```bash
az storage account list \
  --query "[?contains(resourceGroup,'mba')].[name,resourceGroup]" -o table"
```

### List all resources with a certain tag

```bash
az resource list --tag lab=2
```

### Delete all resources with a certain tag

```bash
ids_to_delete=($(az resource list --tag lab=2 --query '[].id' -o tsv))
az resource delete --ids $ids_to_delete
```

### Delete all resource groups with a certain tag

```bash
rg_to_delete=($(az group list \
  --tag action=delete \
  --query '[].name' \
  -o tsv))
for rg in $rg_to_delete
do 
  az group delete --name "$rg" --no-wait -y
done
```

### Filter any resource by tag using jmespath

```bash
az storage account list \
  -g rg-keystore \
  --query "[?tags.labs == '3']"
```
### Export arm template from existing resources

```bash
az group export -g rg-test --skip-all-params -o json > azuredeploy.json
```

### Export arm template from earlier deployments


```bash
lastDeployment=$(az deployment group list \
  -g rg-test \
  --query "sort_by([],&properties.timestamp)[1:].name" -o tsv)

az deployment group export \
  --name $lastDeployment \
  --resource-group rg-test > azuredeploy.json
```

### Validate arm template

```bash
az deployment group validate --template-file azuredeploy.json -g rg-test  
```

### List all changes ARM would perform if the template was deployed

```bash
az deployment group what-if --template-file azuredeploy.json -g rg-test  
```

### Deploy an ARM template

```bash
az deployment group create --template-file azuredeploy.json -g rg-test 
```

### Decompile ARM template to bicep

```bash
bicep decompile azuredeploy.json
```

### Build ARM template from bicep

```bash
bicep build azuredeploy.bicep
```