# Функция для отмены публикации базового приложения и зависимых от него расширений
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

# Функция для отмены публикации и удаления базового приложения
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

# Функция для публикации базового приложения и зависимых от него расширений
function PublishAppAndDependencies($ServerInstance, $ApplicationName)
{
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName} 
    } | ForEach-Object { PublishAppAndDependencies $ServerInstance $_.Name }

    if (Publish-NAVApp -Path $BaseAppPath -ServerInstance $ServerInstance -Force -SkipVerification) {
        Return($true)
    } else {
        Return($false)
    }
}

# Функция для публикации и установки базового приложения
function PublishAndInstall($ServerInstance, $ApplicationName)
{
    if (PublishAppAndDependencies $ServerInstance  $ApplicationName) {
        Install-NAVApp -ServerInstance $ServerInstanceName -Name $ApplicationName
        Return($true)
    } else {
        Return($false)
    }
}

# Командлет для перепубликации и установки базового приложения
# Пример вызова: RepublishBaseApp -ServerInstanceName BC170 -BaseAppPath "C:\ALPOPOV\AL\DemoAL\AL\BaseApp\Microsoft_Base Application_17.1.18256.18792.app"
function RepublishBaseApp {
    param([string]$ServerInstanceName, [string]$BaseAppPath)

    $NAVInfo = Get-NAVAppInfo -ServerInstance $ServerInstanceName | Where-Object {$_.Name -eq "Base Application"}
    if($NAVInfo) {
        UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Base Application"
    }
    if (PublishAndInstall -ServerInstance $ServerInstanceName -ApplicationName "Base Application") {
        Return($true)
    } else {
        Return($false)
    }
}

# Командлет для отмены публикации базового приложения
# Пример вызова: UnpublishBaseApp -ServerInstanceName BC170
function UnpublishBaseApp {
    param([string]$ServerInstanceName)

    if (UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Base Application") {
        Return($true)
    } else {
        Return($false)
    }
}