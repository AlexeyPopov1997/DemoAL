$quietExecution = $null

$quietExecution = git pull

$homeDir = pwd

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

$quietExecution = ./alc.exe /project:$homeDir\.alpackages /packagecachepath:$homeDir\.alpackages

cd $homeDir\Scripts

$quietExecution = ./Modules/NavAdminTool.ps1

$quietExecution = Import-Module ".\Modules\ExtensionAdminTool.psm1"

cd $homeDir
$quietExecution = RepublishApp -ServerInstanceName BC170 -AppPath ".\.alpackages\NSP_GeneralExt_1.0.0.0.app"

$quietExecution = git add .

$commitMessage = Read-Host "`nEnter commit message '<Task ID> <Description from tag documentation>'"

$quietExecution = git commit -m $commitMessage
$quietExecution = git push origin DEV