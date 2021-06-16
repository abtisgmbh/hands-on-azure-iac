# 5 HandsOn Lab Bicep - Deploy vNet Peering


- The bicep file must be called `azuredeploy.bicep`
- A vNet `vnet1` must be created
- `vNet1` must contain two subnets `Subnet-1` and `Subnet-2`
- A vNet `vnet2` must be created
- `vNet2` must contain two subnets `Subnet-1` and `Subnet-2`
- The address spaces for both vNets must not overlap
- A vNet-Peering `myPeering`must be created on `vNet1` with `vNet2` as target
- Both vNets have the tag `lab=5` assigned

## Help and Hints

- Use the Visual Studio Code extension: https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep
- Work with snippets!
- https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks?tabs=bicep
- https://docs.microsoft.com/en-us/azure/templates/microsoft.network/virtualnetworks/virtualnetworkpeerings?tabs=bicep
- The API version used by the vNet peering snippet in vscode does not seem to be correct. This works: `'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-11-01'`
- [solution](solution.bicep)


