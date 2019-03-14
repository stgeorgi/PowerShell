in C:\Users\Public\Downloads
    put process.ps1
    put Bginfo64
    put tempProfile.bgi (config)

Setup BGInfo start up 
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
    "BGInfo"="\"C:\\Users\\Public\\Downloads\\Bginfo64.exe\" C:\\Users\\Public\\Downloads\\tempProfile.bgi /silent /timer:0"

Gpedit
    User Configuration > Windows Settings > Scripts (Logon/Logoff)
    Script name:        powershell.exe 
    Script parameter:   -Command ". 'C:\Users\Public\Downloads\process.ps1'"