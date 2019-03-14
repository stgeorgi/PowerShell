(get-item C:\Windows\System32\WindowsPowerShell\v1.0\Modules\MSOnline\Microsoft.Online.Administration.Automation.PSModule.dll).VersionInfo.FileVersion

Login-AzureRmAccount #admin@WVDbootcamp.onmicrosoft.com

cd C:\Windows\System32\WindowsPowerShell\v1.0\Modules\MSOnline\
Import-Module MSOnlineExtended

Connect-MsolService -AzureEnvironment AzureCloud
