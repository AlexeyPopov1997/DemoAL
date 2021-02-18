$quietExecution = $null

cd..
$currentDir = pwd
$homeDir = "$currentDir\AL\BaseApp"
cd $homeDir

$quietExecution = git pull

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

$quietExecution = ./alc.exe /project:$homeDir /packagecachepath:$homeDir\.alpackages

cd "$currentDir\Scripts"

$quietExecution = ./Modules/NavAdminTool.ps1

$quietExecution = Import-Module ".\Modules\AppAdminTool.psm1"

cd $homeDir

try {
    RepublishBaseApp -ServerInstanceName BC170 -ApplicationName "Base Application" -ApplicationPath ".\Microsoft_Base Application_17.2.19367.19735.app"
    Write-Output "Base Application has been republished successfully."
} catch {
    Exit
}

$quietExecution = git add .

$commitMessage = Read-Host "`nEnter commit message '<Task ID> <Documentation message>'"
if ($commitMessage -notmatch '^[0-9]{5}') {
    Write-Host "The commit message does not contain a task ID."
    break
}

$quietExecution = git commit -m $commitMessage
$quietExecution = git push origin DEV