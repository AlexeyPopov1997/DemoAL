$quietExecution = $null

$quietExecution = git pull

$homeDir = pwd

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

$quietExecution = ./alc.exe /project:$homeDir /packagecachepath:$homeDir\.alpackages

cd $homeDir\scripts

$quietExecution = ./Modules/NavAdminTool.ps1

$quietExecution = Import-Module ".\Modules\BaseAppAdminTool.psm1"

cd $homeDir
$quietExecution = RepublishBaseApp -ServerInstanceName BC170 -AppPath ".\Microsoft_Base Application_17.1.18256.18792.app"

$quietExecution = git add .

$commitMessage = Read-Host "`nEnter commit message '<Task ID> <Developer ID>'"

$quietExecution = git commit -m $commitMessage
$quietExecution = git push origin DEV