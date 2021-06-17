BeforeAll{

    $rgName = $env:ACC_STORAGE_PROFILE -replace '^.+/resourcegroups/([^/]+)/.*$', '$1'
    $vm = az vm list -g $rgName -o json | ConvertFrom-Json
    $vmPublicIp = az vm show -d -g $rgName -n $vm.name -o tsv --query "publicIps"
}

Describe "linux-vm" {
    It "exists exactly one linux vm in the resource group of the cloud shell" {

        $vm.Count | Should -BeGreaterThan 0
    }

    It "has a public ip" {

        $vmPublicIp | Should -Not -BeNullOrEmpty
    }

    It "allows a connection via ssh" {

        (ssh azureuser@$vmPublicIp -- uname) | Should -Be "Linux"
    }
}
