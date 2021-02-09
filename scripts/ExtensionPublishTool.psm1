# Функция для отмены публикации расширения и зависимых от него
function UnpublishAppAndDependencies($ServerInstance, $ApplicationName) {
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName}
    } | ForEach-Object {
        UnpublishAppAndDependencies $ServerInstance $_.Name
    }
    
    Unpublish-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName
}

# Функция для отмены публикации и удаления расширения
function UninstallAndUnpublish($ServerInstance, $ApplicationName) {
    Uninstall-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName -Force
    UnpublishAppAndDependencies $ServerInstance  $ApplicationName
}

# Функция для публикации расширения и зависимых от него
function PublishAppAndDependencies($ServerInstance, $ApplicationName) {
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName} 
    } | ForEach-Object {
        PublishAppAndDependencies $ServerInstance $_.Name
    }
    
    Publish-NAVApp -Path $ApplicationPath -ServerInstance $ServerInstance -Force -SkipVerification
}

# Функция для публикации и установки расширения
function PublishAndInstall($ServerInstance, $ApplicationName) {
    PublishAppAndDependencies $ServerInstance  $ApplicationName
    Install-NAVApp -ServerInstance $ServerInstanceName -Name $ApplicationName
}

# Командлет для перепубликации и установки расширения
# Пример вызова: RepublishApplication -ServerInstanceName BC170 -ApplicationPath "C:\ALPOPOV\AL\DemoAL\ALPOPOV_Customer Extension_1.0.0.0.app"
function RepublishApplication {
    param([string]$ServerInstanceName, [string]$ApplicationPath)
    
    $NAVInfo = Get-NAVAppInfo -ServerInstance $ServerInstanceName | Where-Object {$_.Name -eq "Customer Extension"}
    if($NAVInfo) {
        UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Customer Extension"
    }
    
    $null = PublishAndInstall -ServerInstance $ServerInstanceName -ApplicationName "Customer Extension"
}

# Командлет для отмены публикации расширения
# Пример вызова: UnpublishApplication -ServerInstanceName BC170
function UnpublishApplication {
    param([string]$ServerInstanceName)

    UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Customer Extension"
}