# Функция для отмены публикации базового приложения и зависимых от него расширений
function UnpublishAppAndDependencies($ServerInstance, $ApplicationName)
{
     Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName}
        } | ForEach-Object {
            UnpublishAppAndDependencies $ServerInstance $_.Name
        }

     Unpublish-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName
}

# Функция для отмены публикации и удаления базового приложения
function UninstallAndUnpublish($ServerInstance, $ApplicationName)
{
    Uninstall-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName -Force
    UnpublishAppAndDependencies $ServerInstance  $ApplicationName
}

# Функция для публикации базового приложения и зависимых от него расширений
function PublishAppAndDependencies($ServerInstance, $ApplicationName)
{
     Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {
     (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName} } | ForEach-Object {
        PublishAppAndDependencies $ServerInstance $_.Name
     }

     Publish-NAVApp -Path $BaseAppPath -ServerInstance $ServerInstance -Force -SkipVerification
}

# Функция для публикации и установки базового приложения
function PublishAndInstall($ServerInstance, $ApplicationName)
{
    PublishAppAndDependencies $ServerInstance  $ApplicationName
    Install-NAVApp -ServerInstance $ServerInstanceName -Name $ApplicationName
}

# Командлет для перепубликации и установки базового приложения
# Пример вызова: RepublishBaseApp -ServerInstanceName BC170 -BaseAppPath "C:\ALPOPOV\AL\DemoAL\BaseApplication\Microsoft_Base Application_17.1.18256.18792.app"
function RepublishBaseApp {
param([string]$ServerInstanceName, [string]$BaseAppPath)

    
    $NAVInfo = Get-NAVAppInfo -ServerInstance $ServerInstanceName | Where-Object {$_.Name -eq "Base Application"}
    if($NAVInfo) {
        UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Base Application"
    }
    $null = PublishAndInstall -ServerInstance $ServerInstanceName -ApplicationName "Base Application"
}

# Командлет для отмены публикации базового приложения
# Пример вызова: UnpublishBaseApp -ServerInstanceName BC170
function UnpublishBaseApp {
param([string]$ServerInstanceName)

    UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Base Application"
}