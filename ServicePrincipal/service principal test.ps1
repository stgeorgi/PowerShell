$myTenantGroupName = "WVDValidation"
$myTenantName = "SelfhostTest"
$wvdPowerShellLocation = "C:\temp\PowershellModules"

# Create service principal in Azure AD
Import-Module AzureAD
$aadContext = Connect-AzureAD
$wvdSvcPrincipal = New-AzureADApplication -AvailableToOtherTenants $true -DisplayName "WVDSvcPrincipal"
$wvdSvcPrincipalCreds = New-AzureADApplicationPasswordCredential -ObjectId $wvdSvcPrincipal.ObjectId

# Create role assignment in Windows Virtual Desktop
Import-Module $wvdPowerShellLocation
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvdselfhost.microsoft.com" # stgeorgi@microsfot.com
Set-RdsContext -TenantGroupName $myTenantGroupName
New-RdsRoleAssignment -RoleDefinitionName "RDS Owner" -ApplicationId $wvdSvcPrincipal.AppId -TenantGroupName $myTenantGroupName -TenantName $myTenantName

# Log in to Windows Virtual Desktop with the service principal
$creds = New-Object System.Management.Automation.PSCredential($wvdSvcPrincipal.AppId, (ConvertTo-SecureString $wvdSvcPrincipalCreds.Value -AsPlainText -Force))
Add-RdsAccount -DeploymentUrl "https://rdbroker.wvd.microsoft.com" -Credential $creds -ServicePrincipal -AadTenantId $aadContext.TenantId
