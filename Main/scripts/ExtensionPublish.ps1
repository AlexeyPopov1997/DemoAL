git pull

$homeDir = pwd

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

./alc.exe /project:$homeDir /packagecachepath:$homeDir\.alpackages

cd $homeDir\scripts

./NavAdminTool.ps1

Import-Module ".\ExtensionAdminTool.psm1" -Verbose

RepublishApp -ServerInstanceName BC170 -AppPath ".\NAVICON_Main Extension_1.0.0.0.app"

git push origin DEV 