# Функция для отмены публикации нашего расширения и зависимых от него
function UnpublishAppAndDependencies($ServerInstance, $ApplicationName)
{
     Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName}
        } | ForEach-Object {
            UnpublishAppAndDependencies $ServerInstance $_.Name
        }

     Unpublish-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName
}

# Функция для отмены публикации и удаления нашего расширения
function UninstallAndUnpublish($ServerInstance, $ApplicationName)
{
    Uninstall-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName -Force
    UnpublishAppAndDependencies $ServerInstance  $ApplicationName
}

# Функция для публикации нашего расширения и зависимых от него
function PublishAppAndDependencies($ServerInstance, $ApplicationName)
{
     Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {
     (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName} } | ForEach-Object {
        PublishAppAndDependencies $ServerInstance $_.Name
     }

     Publish-NAVApp -Path $AppPath -ServerInstance $ServerInstance -Force -SkipVerification
}

# Функция для публикации и установки нашего расширения
function PublishAndInstall($ServerInstance, $ApplicationName)
{
    PublishAppAndDependencies $ServerInstance  $ApplicationName
    Install-NAVApp -ServerInstance $ServerInstanceName -Name $ApplicationName
}

# Командлет для перепубликации и установки нашего расширения
# Пример вызова: RepublishApp -ServerInstanceName BC170 -AppPath "C:\ALPOPOV\AL\DemoAL\AL\GeneralExt\NSP_GeneralExt_1.0.0.0.app"
function RepublishApp {
param([string]$ServerInstanceName, [string]$AppPath)

    
    $NAVInfo = Get-NAVAppInfo -ServerInstance $ServerInstanceName | Where-Object {$_.Name -eq "GeneralExt"}
    if($NAVInfo) {
        UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "GeneralExt"
    }
    $null = PublishAndInstall -ServerInstance $ServerInstanceName -ApplicationName "GeneralExt"
    Return($true)
}

# Командлет для отмены публикации нашего расширения
# Пример вызова: UnpublishApp -ServerInstanceName BC170
function UnpublishApp {
param([string]$ServerInstanceName)

    UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "GeneralExt"
}