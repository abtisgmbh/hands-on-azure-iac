Describe "CloudShell" {
    It "runs in the correct environment" {
        $env:POWERSHELL_DISTRIBUTION_CHANNEL| Should -Be "CloudShell"
    }
}
