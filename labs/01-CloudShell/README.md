# 1 HandsOn Lab CloudShell

HandsOn labs will always have a `README.md` file like this that contains the instructions. To check, if all relevant stages of the task have been completed we use Pester.

Pester is a PowerShell framework for all sorts of tests like unit tests or integration tests. Learn more about Pester here: https://pester-docs.netlify.app/

To let Pester run the tests for the HandsOn labs use the following command in PowerShell:

```powershell
Invoke-Pester
```

If you are using bash or zsh use the following script instead:

```bash
chmod +x Invoke-Pester.sh
./Invoke-Pester.sh
```

A pester run looks like the following if a test fails:

```text
Starting discovery in 1 files.
Discovery finished in 155ms.
Running tests.

[-] CloudShell.runs in the correct environment 99ms (83ms|16ms)
 at <ScriptBlock>, /home/mbatsching/git/hands-on-azure-iac/CloudShell/handson/CloudShell.Tests.ps1:3
 Expected 'CloudShell', but got $null.
 at $env:POWERSHELL_DISTRIBUTION_CHANNEL| Should -Be "CloudShell", /home/mbatsching/git/hands-on-azure-iac/CloudShell/handson/CloudShell.Tests.ps1:3

Tests completed in 559ms
Tests Passed: 0, Failed: 1, Skipped: 0 NotRun: 0
```

If a test is successful you will see an output like this instead:

```text
Starting discovery in 1 files.
Discovery finished in 155ms.
Running tests.

[+] CloudShell.runs in the correct environment 99ms (83ms|16ms)

Tests completed in 559ms
Tests Passed: 1, Failed: 0, Skipped: 0 NotRun: 0
```