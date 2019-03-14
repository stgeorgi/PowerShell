# ivan
$pslocation = "C:\temp\PowershellModules"
$brokerurl = "https://rdbroker.wvd.microsoft.com"
$admin = "stgeorgi@microsoft.com"
# fix for TSL
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
####################################################### 
## import PS
cd $pslocation
import-module ".\Microsoft.RdInfra.RdPowershell.dll"
####################################################### 
## remove module
# Get-Module
# remove-module Microsoft.RdInfra.RdPowershell -force
####################################################### 
# connect to infra
Add-RdsAccount -DeploymentUrl $brokerurl 
####################################################### 
# Green team validation tenant 
####################################################### 
#tenant 1:  mismatched UPN with two host pools
#            mismatched UPN with two host pools
$aadid1 = "ad638926-c4fa-462d-8b20-1dd3f162028b"
$tenant1 = "RdsIsmTenant1"
$tenant1f ="Internal"
$tenant1d = "Stgeorgi internal tenant for Rainbow validation with RdsIsmTenant1"
$appgroup = "Desktop Application Group"  
$pool1 = "WS2016-p"

# desktop users
$user1 = "u1@green10ant.com"
$user3 = "u3@green10ant.com"
# app users
$user2 = "u2@green10ant.com"
$user4 = "u4@green10ant.com"
# tenatn creation
Set-RdsTenant -Name $tenant1  -FriendlyName $tenant1f -Description $tenant1d 
Get-RdsTenant -Name $tenant1 

New-RdsHostPool $tenant1 $pool1
Get-RdsHostPool $tenant1 
Set-RdsHostPool $tenant1 $pool1 -UseReverseConnect $false

New-RdsRoleAssignment -TenantName $tenant1 -HostPoolName $pool1  -RoleDefinitionName "RDS Reader" -ApplicationId "74e98113-e2ca-48c8-963d-fe33ae70c756"
Remove-RdsRoleAssignment -TenantName $tenant1 -HostPoolName $pool1 -RoleDefinitionName "RDS Contributor" -ApplicationId "74e98113-e2ca-48c8-963d-fe33ae70c756"
$creds = New-Object System.Management.Automation.PSCredential("74e98113-e2ca-48c8-963d-fe33ae70c756", (ConvertTo-SecureString "9a/FIC3/AviDhOQT6iykOLqknhrKsOmypjFevfpuUEA=" -AsPlainText -Force))
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -Credential $creds -ServicePrincipal -AadTenantId $aadContext.TenantId
#######################################################
# add user to default desktop group
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3
#######################################################
# token generation
New-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile11
Export-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile114
Get-RdsSessionHost $tenant1 $pool1 
Remove-RdsSessionHost $tenant1 $pool1 "rdmiv3-0.green10ant.com" -Force
# cleanup
Get-RdsHostPool -TenantName $tenant1
$pool1 = "WS2016-p"
Get-RdsSessionHost $tenant1 $pool1
# user troubleshoot
Get-RdsDiagnosticActivities -UserName "stefan@gt090617.onmicrosoft.com" -TenantName $tenant 
(Get-RdsDiagnosticActivities -UserName "stefan@gt090617.onmicrosoft.com" -TenantName $tenant -ActivityId "676a54e6-3e86-485d-bc80-eba58d840000" -Detailed).Errors
