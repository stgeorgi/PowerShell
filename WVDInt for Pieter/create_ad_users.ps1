Param (	
	[parameter(mandatory = $false)]
	[String]$pathTo='C:\data\new-users.csv'
)

#---------------------------------------------------------- 
# LOAD ASSEMBLIES AND MODULES 
#---------------------------------------------------------- 
Try 
{ 
  Import-Module ActiveDirectory -ErrorAction Stop 
} 
Catch 
{ 
  Write-Host "[ERROR]`t ActiveDirectory Module couldn't be loaded. Script will stop!" 
  Exit 1 
} 

#Enter a path to your import CSV file
Write-Host "[Info]'t Importing File" 
$Users = Import-CSV $pathTo 

Write-Host $Users

foreach ($user in $Users) 
{
       $Username    = $user.username         
       $Password    = $user.password
       $Firstname   = $user.firstname
       $Lastname    = $user.lastname      

       #Check if the user account already exists in AD
       if (Get-ADUser -F {SamAccountName -eq $Username})
       {
               #If user does exist, output a warning message
               Write-Warning "[Warning]'t A user account $Username has already exist in Active Directory."
               
               
               # add this so I can reuse the same script to update the password
               # Set-ADAccountPassword -Identity $Username -PassThru -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)
               # Set-ADUser -Identity $Username -ChangePasswordAtLogon $False       
       }
       else
       {
        #If a user does not exist then create a new user account
          
        #Account will be created in the OU listed in the $OU variable in the CSV file; don’t forget to change the domain name in the"-UserPrincipalName" variable
            New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@WVDInt.onmicrosoft.com" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -ChangePasswordAtLogon $True `
            -DisplayName "$Lastname, $Firstname" `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force)
       }
}