$quietExecution = $null

$quietExecution = git pull

$homeDir = pwd

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

$quietExecution = ./alc.exe /project:$homeDir /packagecachepath:$homeDir\.alpackages

cd $homeDir\scripts

$quietExecution = ./NavAdminTool.ps1

$quietExecution = Import-Module ".\ExtensionAdminTool.psm1"

cd $homeDir
$quietExecution = RepublishApp -ServerInstanceName BC170 -AppPath ".\NAVICON_Main Extension_1.0.0.0.app"

$quietExecution = git add .

$commitMessage = Read-Host "`nВведите сообщение коммита '<Код задачи> <Код разработчика>'"

$quietExecution = git commit -m "sdgsdfg"
$quietExecution = git push origin DEV