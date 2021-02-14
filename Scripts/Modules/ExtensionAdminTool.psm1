# Функция для отмены публикации нашего расширения и зависимых от него
function UnpublishAppAndDependencies($ServerInstance, $ApplicationName)
{
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName}
    } | ForEach-Object { UnpublishAppAndDependencies $ServerInstance $_.Name }

    if (Unpublish-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName) {
        Return($true)
    } else {
        Return($false)
    }
}

# Функция для отмены публикации и удаления нашего расширения
function UninstallAndUnpublish($ServerInstance, $ApplicationName)
{
    if (Uninstall-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName -Force) {
        if (UnpublishAppAndDependencies $ServerInstance  $ApplicationName) {
            Return($true) 
        } else {
            Return($false)
        }
    } else {
        Return($false)
    }
}

# Функция для публикации нашего расширения и зависимых от него
function PublishAppAndDependencies($ServerInstance, $ApplicationName)
{
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName} 
    } | ForEach-Object { PublishAppAndDependencies $ServerInstance $_.Name }

    if (Publish-NAVApp -Path $AppPath -ServerInstance $ServerInstance -Force -SkipVerification) {
        Return($true)
    } else {
        Return($false)
    }
}

# Функция для публикации и установки нашего расширения
function PublishAndInstall($ServerInstance, $ApplicationName)
{
    if (PublishAppAndDependencies $ServerInstance  $ApplicationName) {
        Install-NAVApp -ServerInstance $ServerInstanceName -Name $ApplicationName
        Return($true)
    } else {
        Return($false)
    }
}

# Командлет для перепубликации и установки нашего расширения
# Пример вызова: RepublishApp -ServerInstanceName BC170 -AppPath "C:\ALPOPOV\AL\DemoAL\AL\GeneralExt\NSP_GeneralExt_1.0.0.0.app"
function RepublishApp {
    param([string]$ServerInstanceName, [string]$AppPath)
    
    $NAVInfo = Get-NAVAppInfo -ServerInstance $ServerInstanceName | Where-Object {$_.Name -eq "GeneralExt"}
    if($NAVInfo) {
        UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "GeneralExt"
    }
    if (PublishAndInstall -ServerInstance $ServerInstanceName -ApplicationName "GeneralExt") {
        Return($true)
    } else {
        Return($false)
    }
}

# Командлет для отмены публикации нашего расширения
# Пример вызова: UnpublishApp -ServerInstanceName BC170
function UnpublishApp {
    param([string]$ServerInstanceName)
    
    if (UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "GeneralExt") {
        Return($true)
    } else {
        Return($false)
    }
}