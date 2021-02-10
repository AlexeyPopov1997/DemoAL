$userName = $env:username

git pull

cd "C:\Users\" + "$userName" + "\.vscode\extensions\ms-dynamics-smb.al-6.1.397164\bin\"

./alc.exe /project:C:\ALPOPOV\AL\DemoAL\Main /packagecachepath:C:\ALPOPOV\AL\DemoAL\Main\.alpackages

cd scripts

./NavAdminTool.ps1

Import-Module ".\ExtensionAdminTool.psm1" -Verbose

RepublishApp -ServerInstanceName BC170 -AppPath ".\ALPOPOV_Customer Extension_1.0.0.0.app"

git push origin DEV 

yjhkgjkhjlk
