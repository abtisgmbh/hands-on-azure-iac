BeforeAll {
    $armFile = "./azuredeploy.json"
    $rgName = $env:ACC_STORAGE_PROFILE -replace '^.+/resourcegroups/([^/]+)/.*$', '$1'
    $arm = Get-Content $armFile | ConvertFrom-Json
    
    $saResource = ($arm.resources | Where-Object type -eq 'Microsoft.Storage/storageAccounts')
    $validation = az deployment group validate --template-file $armFile -g $rgName -o json | ConvertFrom-Json
    $saName = $validation.properties.validatedResources[0].id -replace '^.*/' 
}

Describe "arm-storageaccount" {
    
    It "should be a valid template" {
        $validation.properties.provisioningState |  Should -Be "Succeeded"
    }

    It "creates only one storage account" {

        $saResource.Count | Should -Be 1
    }

    It "uses Standard_LRS as sku" {

        $saResource.sku.name | Should -Be "Standard_LRS"
    }

    It "is a General Purpose v2 storage account" {

        $saResource.kind | Should -Be "StorageV2"
    }

    It "defaults to the Hot access tier" {

        $saResource.properties.accessTier | Should -Be "Hot"
    }

    It "should be deployed to correct resource group and carry the proper tag" {
        az storage account list -g $rgName --query '[?tags.labs == '3'].name' -o tsv |  Should -Be $saName
    }
}
