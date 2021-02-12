$null = git pull

$homeDir = pwd

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

./alc.exe /project:$homeDir /packagecachepath:$homeDir\.alpackages

cd $homeDir\scripts

$null = ./NavAdminTool.ps1

$null = Import-Module ".\ExtensionAdminTool.psm1"

cd $homeDir
$null = RepublishApp -ServerInstanceName BC170 -AppPath ".\NAVICON_Main Extension_1.0.0.0.app"

$null = git add .
$null = git commit -m "sdgsdfg"
$null = git push origin DEV 