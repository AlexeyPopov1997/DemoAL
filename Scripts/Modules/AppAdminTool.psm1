function UnpublishAppAndDependencies($ServerInstance, $AppName) {
    Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
        (Get-NavAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {
            $_.Name -eq $AppName
        }
    } | ForEach-Object {
        UnpublishAppAndDependencies $ServerInstance $_.Name
    }
    
    Unpublish-NavApp -ServerInstance $ServerInstance -Name $AppName
}


function UninstallAndUnpublish($ServerInstance, $AppName) {
    Uninstall-NavApp -ServerInstance $ServerInstance -Name $AppName -Force
    UnpublishAppAndDependencies $ServerInstance  $AppName
}


function PublishAndInstall($ServerInstance, $AppName, $AppPath) {
    Publish-NavApp -ServerInstance $ServerInstance -Path $AppPath -Force -SkipVerification
    if($AppName = "Base Application") {
        Get-NAVAppInfo -ServerInstance $ServerInstance | Where-Object { 
            (Get-NavAppInfo -ServerInstance $ServerInstance -Name $_.Name).Dependencies | Where-Object {
                $_.Name -eq $AppName
            }
        } | ForEach-Object {
            Install-NavApp -ServerInstance $ServerInstance -Name $_.Name -Force
        }
    } else {
        Install-NavApp -ServerInstance $ServerInstance -Name $AppName -Force
    }
}  


# Republish -ServerInstanceName BC170 -ApplicationName "Base Application" -ApplicationPath "C:\ALPOPOV\AL\DemoAL\AL\BaseApp\Microsoft_Base Application_17.1.18256.18792.app"
# Republish -ServerInstanceName BC170 -ApplicationName "GeneralExt" -ApplicationPath "C:\ALPOPOV\AL\DemoAL\AL\GeneralExt\NSP_GeneralExt_1.0.0.0.app"
function Republish {
    param([string]$ServerInstanceName, [string]$ApplicationName, [string]$ApplicationPath)

    UninstallAndUnpublish -ServerInstance $ServerInstanceName -AppName $ApplicationName
    PublishAndInstall -ServerInstance $ServerInstanceName -AppName $ApplicationName -AppPath $ApplicationPath 
}