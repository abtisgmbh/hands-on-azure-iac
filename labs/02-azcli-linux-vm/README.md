# 2 HandsOn Lab AzureCLI - Deploy Linux VM

- Use AzureCLI to create a single virtual machine into the resource group that you created for your cloud shell.

## Requirements:

- There must be an administrative user called 'azureuser'
- The vm image to be used is 'UbuntuLTS'
- SSH key pair is used for authentication
- The fingerprint of the vm needs to be added to known hosts (happens automatically on first login via ssh)
- The vm must carry the tag `lab=2`


## Help and Hints:

- Use `az vm --help` 
- https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-cli
- [solution](solution.sh)