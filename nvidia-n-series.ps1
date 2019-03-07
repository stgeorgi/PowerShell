$pslocation = "C:\temp\PowershellModules"
$brokerurl = "https://rdbroker.wvd.microsoft.com"

# fix for TSL
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# import PS
cd $pslocation
import-module ".\Microsoft.RdInfra.RdPowershell.dll"

# connect to infra
Add-RdsAccount -DeploymentUrl $brokerurl 

# Tenant 
$aadid1 = "6265f4e8-c5f1-4ac2-b92e-f372e0e78405"
$tenant1 = "Gt1002-t"
$tenant1f ="WVDContoso.com"
$tenant1d = "Stgeorgi internal tenant for Rainbow validation"
$appgroup = "Desktop Application Group"  

$pool1 = "Win10N"
$regfile11 = "C:\temp\reg.reg"

New-RdsHostPool $tenant1 $pool1
New-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile11

Get-RdsSessionHost $tenant1 $pool1
Set-RdsTenant -Name $tenant1 -FriendlyName $tenant1f
# users
$user1 = "s11@wvdcontoso.com"
$user2 = "s88@wvdcontoso.com"
$user3 = "s77@wvdcontoso.com"

Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3
# cleanup
Remove-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Remove-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Remove-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3
# 
Get-RdsHostPool $tenant1

Set-RdsRemoteDesktop -TenantName $tenant1 -HostPoolName $pool1 -AppGroupName "Desktop Application Group" -FriendlyName "NV Series Win 10 MS"

# Win2016N
$pool1 = "Win2016N"
New-RdsHostPool $tenant1 $pool1
New-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile11

Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3

Get-RdsHostPool $tenant1 
Get-RdsSessionHost $tenant1 MswithAF
Get-RdsAppGroupUser $tenant1 MswithAF $appgroup

Set-RdsRemoteDesktop -TenantName $tenant1 -HostPoolName $pool1 -AppGroupName "Desktop Application Group" -FriendlyName "NV Series WS 2016"

# MswithAF
Get-RdsHostPool $tenant1 $pool1
$pool1 = "MswithAF"
New-RdsHostPool $tenant1 $pool1
New-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile11

Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup "stefan@wvdcontoso.com"

Get-RdsAppGroupUser $tenant1 $pool1 $appgroup

Get-RdsSessionHost $tenant1 $pool1

Set-RdsRemoteDesktop -TenantName $tenant1 -HostPoolName $pool1 -AppGroupName "Desktop Application Group" -FriendlyName "W10MS+AF+AD"

# Win10MSHP

$pool1 = "Win10MSHP"
New-RdsHostPool $tenant1 $pool1
New-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile11

$user1 = "scott@wvdcontoso.com"
$user2 = "scottM@wvdcontoso.com"
$user4 = "samsung@wvdcontoso.com"
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user4

$user2 = "Stefan@wvdcontoso.com"
$user3 = "DavidB@wvdcontoso.com"
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3

Get-RdsSessionHost $tenant1 $pool1

Set-RdsRemoteDesktop -TenantName $tenant1 -HostPoolName $pool1 -AppGroupName "Desktop Application Group" -FriendlyName "Win 10 Multi-User with Profiles"

# App group
$user3 = "David@wvdcontoso.com"
Remove-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3
Get-RdsAppGroup $tenant1 $pool1
$appgroup2 = "Remote apps"
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup2 $user3

Get-RdsRemoteApp $tenant1 $pool1 $appgroup2 
Remove-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name IOT

New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "Visual Studio Code" -AppAlias visualstudiocode
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "MS Word" -AppAlias word
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "WordPad" -AppAlias wordpad
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "Excel" -AppAlias excel
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "FireFox" -AppAlias firefox
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "Chrome" -AppAlias googlechrome
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "Notepad PlusPlus" -AppAlias notepad
New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name "OneNote" -AppAlias onenote2016

New-RdsRemoteApp $tenant1 $pool1 $appgroup2 -Name Edge -FilePath shell:Appsfolder\Microsoft.MicrosoftEdge_8wekyb3d8bbwe!MicrosoftEdge -IconPath C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe
# App Group publish appattach
Get-RdsHostPool $tenant1 $pool1
Get-RdsSessionHost $tenant1 $pool1
$appgroup3 = "AppAttach"
New-RdsAppGroup $tenant1 $pool1 -Name $appgroup3 -ResourceType "RemoteApp"
Get-RdsAppGroup $tenant1 $pool1 -Name $appgroup3
Get-RdsStartMenuApp $tenant1 $pool1 $appgroup3

$user1 = "s11@wvdcontoso.com"
$user2 = "s22@wvdcontoso.com"
$user3 = "s33@wvdcontoso.com"
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup3 $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup3 $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup3 $user3
# 
Get-RdsAppGroupUser $tenant1 $pool1 $appgroup3 

New-RdsRemoteApp $tenant1 $pool1 $appgroup3 -Name VLC_appattach -FilePath "C:\vlc_redir\VFS\ProgramFilesX64\VideoLAN\VLC\vlc.exe" -IconPath "C:\vlc_redir\VFS\ProgramFilesX64\VideoLAN\VLC\vlc.exe" -IconIndex 0
New-RdsRemoteApp $tenant1 $pool1 $appgroup3 -Name "Visual Studio Code" -AppAlias visualstudiocode

Remove-RdsRemoteApp $tenant1 $pool1 $appgroup3 -Name VLC_appattach
Remove-RdsRemoteApp $tenant1 $pool1 $appgroup3 -Name visualstudiocode

# Sotuhworks UI
while($true)
{
    Read-Host -Prompt "Press Enter to generate a token"
 
    (Get-Variable "AdalContext").Value.GetAcquireTokenAsync().Wait()
 
    (Get-Variable "AdalContext").Value.authResult.AccessToken
 
    Write-Host "";
}

### OLD below 
$pool1 = "fslogix10"
New-RdsHostPool $tenant1 $pool1
Set-RdsHostPool $tenant1 $pool1 -UseReverseConnect $false
New-RdsRegistrationInfo $tenant1 $pool1 | Select-Object -ExpandProperty Token > $regfile11
Get-RdsSessionHost $tenant1 $pool1

Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user1
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user2
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user3
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup $user4
#

$pool3 = "Win10custom"
New-RdsHostPool $tenant1 $pool3
Set-RdsHostPool $tenant1 $pool3 -UseReverseConnect $false
New-RdsRegistrationInfo $tenant1 $pool3 | Select-Object -ExpandProperty Token > $regfile11
Get-RdsSessionHost $tenant1 $pool1

Get-RdsSessionHost $tenant1  WS2016-p -SessionHostName "gt16sh2.GT090617.onmicrosoft.com" -SessionId 1 -MessageTitle $LogOffMessageTitle -MessageBody "Test" -NoConfirm:$false
Send-RdsUserSessionMessage -TenantName $tenant1 -HostPoolName  WS2016-p -SessionHostName "gt16sh2.GT090617.onmicrosoft.com" -SessionId 1 -MessageTitle "test" -MessageBody "Body" -NoConfirm $false

#


#Ivan: mismatched UPN with two host pools
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
#######################################################
#app group setup
$appgroup1 = "Geek Department Apps"
New-RdsAppGroup $tenant1 $pool1 -Name $appgroup1 -ResourceType "RemoteApp"
# add user
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup1 $user2 
Add-RdsAppGroupUser $tenant1 $pool1 $appgroup1 $user4
Get-RdsAppGroupUser $tenant1 $pool1 $appgroup1 
# app via actual path
$remoteapp1 = "Word Pad - Plain"
New-RdsRemoteApp $tenant1 $pool1 $appgroup1 -Name $remoteapp1 -FriendlyName $remoteapp1 -FilePath "C:\Program Files\Windows NT\Accessories\wordpad.exe" -IconPath "C:\Program Files\Windows NT\Accessories\wordpad.exe" -IconIndex 0 
# via alias
Get-RdsStartMenuApp $tenant1 $pool1 $appgroup1
$remoteapp2 = "Ms Paint - Via Alias"
New-RdsRemoteApp $tenant1 $pool1 $appgroup1 -Name $remoteapp2 -AppAlias paint
New-RdsRemoteApp $tenant1 $pool1 $appgroup1 -Name Calc -AppAlias calculator
# scaling user permissions
New-RdsRoleAssignment -RoleDefinitionName "RDS Owner" -SignInName "admin@gt090617.onmicrosoft.com" -TenantName $tenant1 
Get-RdsUserSession -TenantName $tenant1 -HostPoolName $pool1

Get-RdsTenant 

# Roop tenant AVDContoso
Get-RdsTenantGroup -Name "WVDValidation"
Set-RdsContext -TenantGroupName "WVDValidation"
New-RdsTenant -Name AVDContoso -AadTenantId e7f92427-2317-443f-b180-0ae2b1939bab -FriendlyName "AVD Contoso" -Description "Owner Rkiran"
New-RdsRoleAssignment -SignInName "roop@Avdcontoso.com" -RoleDefinitionName "RDS Owner" -TenantName "AVDContoso"
New-RdsRoleAssignment -SignInName "stefan@Avdcontoso.com" -RoleDefinitionName "RDS Owner" -TenantName "AVDContoso"

Get-RdsUserSession -TenantName Office -HostPoolName "Office Users"
# Set-RdsE  -TenantName Office -HostPoolName "Office Users" 
Get-RdsHostPool -TenantName Office 
Remove-RdsSessionHost -TenantName Office -HostPoolName "Office Users" "SH-04.redmond.corp.microsoft.com" -force
Get-RdsSessionHost -TenantName Office -HostPoolName "Office Users" 

New-RdsRoleAssignment -TenantName Office -UserPrincipalName 'ericjose@microsoft.com' -RoleDefinitionName "RDS Operator"
Get-RdsDiagnosticActivities -UserName ericjose@microsoft.com -TenantName Office -Outcome Failure
$obj = Get-RdsDiagnosticActivities -ActivityId bf22d9fd-b17c-40df-932e-5edd116e0000 -Detailed -TenantName Office
$obj.Errors
$obj.Details
$obj.Checkpoints

Get-RdsSessionHost 

New-RdsRegistrationInfo -TenantName Office -HostPoolName "Office Users" | Select-Object -ExpandProperty Token > $regfile11
Remove-RdsRegistrationInfo -TenantName Office -HostPoolName "Office Users" | Select-Object -ExpandProperty Token > $regfile11
Add-RdsAppGroupUser -TenantName Office -HostPoolName "Office Users" -AppGroupName $appgroup -UserPrincipalName "micsmith@microsoft.com"

Get-RdsTenant 
Get-RdsTenant -Name Office -FriendlyName "Office on WVD"

Get-RdsTenant -Name Gt1002-t
Get-RdsHostPool -TenantName Gt1002-t
Get-RdsSessionHost -TenantName Gt1002-t -HostPoolName  WS2016-p
Get-RdsAppGroup  -TenantName Gt1002-t -HostPoolName WS2019-p

Get-RdsDiagnosticActivities -ActivityId e3c3c28f-19e7-4b58-aa4f-4d4986c043ee -TenantName jojenner

(Get-RdsDiagnosticActivities -TenantName Gt1002-t -username david@wvdcontoso.com -detailed).Errors
(Get-RdsDiagnosticActivities -TenantName Gt1002-t -username s11@gt090617.onmicrosoft.com -ActivityId 1d2f74da-2045-4a11-af66-020f52210000 -detailed).Errors

Get-RdsAppGroup -TenantName $tenant1 -HostPoolName WS2019-p
Get-RdsAppGroupUser -TenantName $tenant1 -HostPoolName WS2019-p -AppGroupName $appgroup1
Get-RdsRemoteApp  -TenantName $tenant1 -HostPoolName WS2019-p -AppGroupName $appgroup1
Get-RdsStartMenuApp -TenantName $tenant1 -HostPoolName WS2016-p -AppGroupName $appgroup1

Remove-RdsRemoteApp  -TenantName $tenant1 -HostPoolName WS2019-p -AppGroupName $appgroup1 -Name "Word Pad - Plain"

# $ps1 = New-Object System.Management.Automation.PSCredential("e162bede-f22f-418d-8708-24aea0588ff0", (ConvertTo-SecureString "hlLHO9778]~anqevHPFW8+-" -AsPlainText -Force))
# Add-RdsAccount -DeploymentUrl $brokerurl -TenantId 6265f4e8-c5f1-4ac2-b92e-f372e0e78405 -Credential $ps1 -ServicePrincipal
# Get-RdsRoleAssignment

# Clean up
Get-RdsContext
Get-RdsTenant -Name $tenant1

$myTenantGroupName
$myTenantName
$wvdPowerShellLocation

Set-RdsContext -TenantGroupName WVDValidation
Get-RdsTenant 

Get-RdsHostPool -TenantName $tenant1 
Set-RdsHostPool -TenantName $tenant1 $hostpooldel -FriendlyName "WinServer16"
$hostpooldel = "fslogix10"

Set-RdsRemoteDesktop -TenantName $tenant1 -HostPoolName $hostpooldel -AppGroupName "Desktop Application Group" -FriendlyName "WS 2016 License"

Get-RdsSessionHost -TenantName $tenant1 $hostpooldel

Add-RdsAppGroupUser $tenant1 $hostpooldel $appgroup $user1

Remove-RdsHostPool -TenantName $tenant1 $hostpooldel
Get-RdsAppGroup -TenantName $tenant1 $hostpooldel
Remove-RdsAppGroup  -TenantName $tenant1 $hostpooldel "Desktop Application Group"
Remove-RdsAppGroup  -TenantName $tenant1 $hostpooldel "Geek Department Apps"

Remove-RdsSessionHost -TenantName $tenant1 $hostpooldel base-2.GT090617.onmicrosoft.com -Force

Get-RdsDiagnosticActivities -UserName "stefan@gt090617.onmicrosoft.com" -TenantName $tenant 
(Get-RdsDiagnosticActivities -UserName "stefan@gt090617.onmicrosoft.com" -TenantName $tenant -ActivityId "676a54e6-3e86-485d-bc80-eba58d840000" -Detailed).Errors

New-RdsTenant -Name "jojenner" -AadTenantId "e793c25a-1aa3-4b80-8bc8-4a07b3ed7d11" -FriendlyName "MS Ready WVD-1" -Description "MS Ready WVD-1"
New-RdsRoleAssignment -TenantName "jojenner" -SignInName "msreadywvd1@msreadywvd1.onmicrosoft.com" -RoleDefinitionName "RDS Owner"

# Tenant 
Set-RdsContext -TenantGroupName "Microsoft Internal"

$aadid1 = "dac25a27-3866-4d6c-942b-0b0011e658c0"
$tenant1 = "Redmond1232"
$tenant1f ="Internal"
$tenant1d = "Stgeorgi / risanc"

$user = "azadmin@redmond1232.onmicrosoft.com"

New-RdsTenant -Name $tenant1 -AadTenantId $aadid1 -FriendlyName $tenant1f -Description $tenant1d
New-RdsRoleAssignment -TenantName $tenant1 -SignInName $user -RoleDefinitionName "RDS Owner"

Remove-RdsTenant -Name $tenant1
Get-RdsContext
Get-RdsTenant $tenant1

#
$aadid1 = "56a942ba-6b5f-4561-8ecc-68b23943492a"
$tenant1 = "redmond13114"
$tenant1f ="Internal"
$tenant1d = "John Korkes / risanc"

$user = "AzAdmin@redmond13114.onmicrosoft.com"

New-RdsTenant -Name $tenant1 -AadTenantId $aadid1 -FriendlyName $tenant1f -Description $tenant1d
New-RdsRoleAssignment -TenantName $tenant1 -SignInName $user -RoleDefinitionName "RDS Owner"

Remove-RdsTenant -Name $tenant1
Get-RdsContext
Get-RdsTenant $tenant1



# tenant for denis
Set-RdsContext -TenantGroupName "Microsoft Internal"

$user = "denisgun@fdwl01.onmicrosoft.com"
$aadid1 = "621ba992-ee05-4374-9cd8-9195a9a40992"
$tenant1 = "denisgun"
$tenant1f ="Internal"
$tenant1d = "denisgun / stgeorgi"

New-RdsTenant -Name $tenant1 -AadTenantId $aadid1 -FriendlyName $tenant1f -Description $tenant1d
New-RdsRoleAssignment -TenantName $tenant1 -SignInName $user -RoleDefinitionName "RDS Owner"

Get-RdsHostPool -TenantName WVDBootcamp
Get-RdsSessionHost -TenantName WVDBootcamp -HostPoolName demoHP
Export-RdsRegistrationInfo -TenantName WVDBootcamp -HostPoolName demoHP