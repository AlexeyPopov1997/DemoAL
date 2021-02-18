# Base Application 
function UnpublishAppAndDependencies($ServerInstance, $AppName) {
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NavAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {
            $_.Name -eq $AppName
        }
    } | ForEach-Object {
        UnpublishAppAndDependencies $ServerInstance $_.Name
    }
    
    try {
        Unpublish-NavApp -ServerInstance $ServerInstance -Name $AppName
    } catch {
        Write-Output "Function 'UnpublishAppAndDependencies': Error when unpublishing extension $AppName!"
        Exit
    }
}


# Base Application 
function UninstallAndUnpublish($ServerInstance, $AppName) {
    try {
        Uninstall-NavApp -ServerInstance $ServerInstance -Name $AppName -Force
    } catch {
        Write-Output "Function 'UninstallAndUnpublish': Error when uninstalling extension $AppName!"
        Exit
    }

    try {
        UnpublishAppAndDependencies $ServerInstance  $AppName
    } catch {
        Exit
    }
}


# Any 
function PublishAndInstall($ServerInstance, $AppName, $AppPath) {
    try {
        Publish-NavApp -ServerInstance $ServerInstance -Path $AppPath -Force -SkipVerification
    } catch {
        Write-Output "Function 'PublishAndInstall': Error when publishing extension $AppName!"
        Exit
    }

    try {
        Sync-NAVApp -ServerInstance $ServerInstance -Path $AppPath -Tenant 'default'
    } catch {
        Write-Output "Function 'PublishAndInstall': Error when synchronizing extension $AppName!"
        Exit
    }

    try {
        Install-NavApp -ServerInstance $ServerInstance -Name $AppName -Force
    } catch {
        Write-Output "Function 'PublishAndInstall': Error when installing extension $AppName!"
        Exit
    }
}  


# Extension
# Example: Republish -ServerInstanceName BC170 -ApplicationName "GeneralExt" -ApplicationPath "C:\ALPOPOV\AL\DemoAL\AL\GeneralExt\NSP_GeneralExt_1.0.0.0.app"
function RepublishExtension {
    param([string]$ServerInstanceName, [string]$ApplicationName, [string]$ApplicationPath)

    try {
        Uninstall-NavApp -ServerInstance $ServerInstanceName -Name $ApplicationName -Force
    } catch {
        Write-Output "Function 'Republish': Error when uninstalling extension $AppName!"
        Exit
    }

    try {
        Unpublish-NavApp -ServerInstance $ServerInstanceName -Name $ApplicationName
    } catch {
        Write-Output "Function 'Republish': Error when unpublishing extension $AppName!"
        Exit
    }

    try {
        PublishAndInstall -ServerInstance $ServerInstanceName -AppName $ApplicationName -AppPath $ApplicationPath
    } catch {
        Exit
    }
}


# Base Application 
# Example: Republish -ServerInstanceName BC170 -ApplicationName "Base Application" -ApplicationPath "C:\ALPOPOV\AL\DemoAL\AL\BaseApp\Microsoft_Base Application_17.1.18256.18792.app"
function RepublishBaseApp {
    param([string]$ServerInstanceName, [string]$ApplicationName, [string]$ApplicationPath)

    try {
        UninstallAndUnpublish -ServerInstance $ServerInstanceName -AppName $ApplicationName
    } catch {
        Exit
    }

    try {
        PublishAndInstall -ServerInstance $ServerInstanceName -AppName $ApplicationName -AppPath $ApplicationPath
    } catch {
        Exit
    } 
}