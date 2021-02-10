# Функция для отмены публикации расширения и зависимых от него
# [Internal]
function UnpublishAppAndDependencies($ServerInstance, $ApplicationName) {
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName}
    } | ForEach-Object {
        UnpublishAppAndDependencies $ServerInstance $_.Name
    }
    
    Unpublish-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName
}

# Функция для отмены публикации и удаления расширения
# [Comandlet]
function UninstallAndUnpublish($ServerInstance, $ApplicationName) {
    Uninstall-NAVApp -ServerInstance $ServerInstance -Name $ApplicationName -Force
    UnpublishAppAndDependencies $ServerInstance  $ApplicationName
}

# Функция для публикации расширения и зависимых от него
function PublishAppAndDependencies($ServerInstance, $ApplicationName, $ApplicationPath) {
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {
        (Get-NAVAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {$_.Name -eq $ApplicationName} 
    } | ForEach-Object {
        PublishAppAndDependencies $ServerInstance $_.Name
    }
    
    Publish-NAVApp -ServerInstance $ServerInstance -Path $ApplicationPath -Force -SkipVerification
}

# Функция для публикации и установки расширения
function PublishAndInstall($ServerInstance, $ApplicationName, $ApplicationPath) {
    PublishAppAndDependencies $ServerInstance  $ApplicationName $ApplicationPath
    Install-NAVApp -ServerInstance $ServerInstance -Path $ApplicationPath -Tenant "Tenant1" 
}

# Командлет для перепубликации и установки расширения
# Пример вызова: RepublishApplication -ServerInstance BC170 -ApplicationName "Customer Extension" -ApplicationPath "C:\ALPOPOV\AL\DemoAL\ALPOPOV_Customer Extension_1.0.0.0.app"
function RepublishApplication {
    param([string]$ServerInstance, [string]$ApplicationName, [string]$ApplicationPath)
    
    $NAVInfo = Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object {$_.Name -eq $ApplicationName}
    if($NAVInfo) {
        UninstallAndUnpublish -ServerInstance $ServerInstance -ApplicationName $ApplicationName
    }
    
    $null = PublishAndInstall -ServerInstance $ServerInstance -ApplicationName $ApplicationName -ApplicationPath $ApplicationPath
}


###############################################################################################################################################################
###############################################################################################################################################################

# Командлет для отмены публикации расширения
# Пример вызова: UnpublishApplication -ServerInstanceName BC170
function UnpublishApplication {
    param([string]$ServerInstanceName)

    UninstallAndUnpublish -ServerInstance $ServerInstanceName -ApplicationName "Customer Extension"
}