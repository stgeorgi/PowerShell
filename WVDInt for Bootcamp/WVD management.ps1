$pslocation = "C:\temp\PowershellModules"
# original green built 20180809.3-1.0.0.844
$brokerurl = "https://rdbroker.wvd.microsoft.com"

# fix for TSL
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# import PS
cd $pslocation
import-module ".\Microsoft.RdInfra.RdPowershell.dll"

# connect to infra
Add-RdsAccount -DeploymentUrl $brokerurl $admin

$tenant = "WVDInt"
$defaultG = "Microsoft Internal"
$regfile11 = "C:\temp\reg.reg"
$pool = "Win10MShosts"
$pool1 = "RemoteApps"
$appgroup = "Desktop Application Group"  
$appgroup1 = "RemoteApp Application Group"

Set-RdsContext $defaultG 

Get-RdsTenant -Name $tenant
Set-RdsTenant -Name $tenant -FriendlyName "WVDInt Demo Tenant" -Description "Administered by Stefan.Georgiev@micropsoft.com. For question contact Pieter.Wigleven@microsoft.com"

Get-RdsHostPool -TenantName $tenant
New-RdsHostPool -TenantName $tenant -Name $pool
New-RdsHostPool -TenantName $tenant -Name $pool1

New-RdsRegistrationInfo $tenant $pool | Select-Object -ExpandProperty Token > $regfile11
New-RdsRegistrationInfo $tenant $pool1 | Select-Object -ExpandProperty Token > $regfile11

# Remote Desktop
Get-RdsSessionHost -TenantName $tenant -HostPoolName $pool
# Remove-RdsSessionHost -TenantName $tenant -HostPoolName $pool -SessionHostName "demoHost-1.WVDInt.onmicrosoft.com"

$userArray = "user001@wvdbootcamp.onmicrosoft.com" # intentionally truncated 

foreach ($user in $userArray) {
    Add-RdsAppGroupUser -TenantName $tenant -HostPoolName $pool -AppGroupName $appgroup -UserPrincipalName $user
}
Get-RdsAppGroupUser -TenantName $tenant -HostPoolName $pool -AppGroupName $appgroup

Set-RdsRemoteDesktop -TenantName $tenant -HostPoolName $pool -AppGroupName $appgroup -FriendlyName "Win 10 MS"

# Remote App
Get-RdsSessionHost -TenantName $tenant -HostPoolName $pool1
New-RdsAppGroup -TenantName $tenant -HostPoolName $pool1 -Name $appgroup1 -ResourceType RemoteApp

foreach ($user in $userArray) {
    Add-RdsAppGroupUser -TenantName $tenant -HostPoolName $pool1 -AppGroupName $appgroup1 -UserPrincipalName $user
}
Get-RdsAppGroupUser -TenantName $tenant -HostPoolName $pool1 -AppGroupName $appgroup1

New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "Visual Studio Code" -AppAlias visualstudiocode
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "MS Word" -AppAlias word
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "WordPad" -AppAlias wordpad
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "Excel" -AppAlias excel
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "FireFox" -AppAlias firefox
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "Chrome" -AppAlias googlechrome
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "Notepad PlusPlus" -AppAlias notepad
New-RdsRemoteApp $tenant $pool1 $appgroup1 -Name "OneNote" -AppAlias onenote2016

