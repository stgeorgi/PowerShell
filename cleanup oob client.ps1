# PowerShell Script to cleanup the RD OOB client reg keys and files

#Remove FeedURLs registry value
Remove-ItemProperty 'HKCU:\Software\Microsoft\Terminal Server Client\Default' -Name FeedURLs

#Remove RdClientRadc registry key
Remove-Item 'HKCU:\Software\Microsoft\RdClientRadc' -Recurse

#Remove all files under %appdata%\RdClientRadc
Remove-Item C:\Users\stgeorgi\AppData\Roaming\RdClientRadc\* -Recurse
