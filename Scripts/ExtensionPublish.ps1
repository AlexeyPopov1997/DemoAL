$quietExecution = $null

cd..
$currentDir = pwd
$homeDir = "$currentDir\AL\GeneralExt"
cd $homeDir

$quietExecution = git pull

$userName = $env:username
cd "C:\Users\$userName\.vscode\extensions\"
$extensionName = Get-ChildItem -Name -Filter "ms-dynamics-smb.al*"

cd "C:\Users\$userName\.vscode\extensions\$extensionName\bin\"

$quietExecution = ./alc.exe /project:$homeDir /packagecachepath:$homeDir\.alpackages

cd "$currentDir\Scripts"

$quietExecution = ./Modules/NavAdminTool.ps1

$quietExecution = Import-Module ".\Modules\ExtensionAdminTool.psm1"

cd $homeDir
if(RepublishApp -ServerInstanceName BC170 -AppPath ".\NSP_GeneralExt_1.0.0.0.app") {
    Write-Host "Ceneral Extension was published successfully."
} else {
    break
}

$quietExecution = git add .

$commitMessage = Read-Host "`nEnter commit message '<Task ID> <Documentation message>'"
if ($commitMessage -notmatch '^[0-9]{5}') {
    Write-Host "The commit message does not contain a task ID."
    break
}

$quietExecution = git commit -m $commitMessage
$quietExecution = git push origin main
