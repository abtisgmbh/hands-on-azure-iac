# 4 HandsOn Lab ARM - Deploy Storage Account

Create ARM template to deploy a storage account and deploy it to the resource group of the cloud shell instance

## Requirements

- The ARM template must be called `azuredeploy.json`
- `Standard_LRS` is used as sku
- Hot access tier for blobs
- General Purpose v2 account
- It carries the tag `labs=4`


## Help and Hints

- Use the Visual Studio Code extension: https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools
- https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?tabs=json
- https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-add-tags?tabs=azure-cli
- [solution](solution.json)