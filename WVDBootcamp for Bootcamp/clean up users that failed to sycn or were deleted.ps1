﻿Install-Module AzureAD
Install-Module AzureRM 
Install-Module MSOnline

Import-Module MSOnlineExtended

Login-AzureRmAccount

Connect-MsolService -AzureEnvironment AzureCloud

Set-MsolDirSyncEnabled –EnableDirSync $false
Set-MsolDirSyncEnabled –EnableDirSync $true

(Get-MSOLCompanyInformation).DirectorySynchronizationEnabled 

Remove-MsolUser -UserPrincipalName "user014@WVDbootcamp.onmicrosoft.com" -Force

Get-AzureADUser 

$userArray = "user001@wvdbootcamp.onmicrosoft.com","user002@wvdbootcamp.onmicrosoft.com","user003@wvdbootcamp.onmicrosoft.com","user004@wvdbootcamp.onmicrosoft.com","user005@wvdbootcamp.onmicrosoft.com","user006@wvdbootcamp.onmicrosoft.com","user007@wvdbootcamp.onmicrosoft.com","user008@wvdbootcamp.onmicrosoft.com","user009@wvdbootcamp.onmicrosoft.com","user010@wvdbootcamp.onmicrosoft.com","user011@wvdbootcamp.onmicrosoft.com","user012@wvdbootcamp.onmicrosoft.com","user013@wvdbootcamp.onmicrosoft.com","user014@wvdbootcamp.onmicrosoft.com","user015@wvdbootcamp.onmicrosoft.com","user016@wvdbootcamp.onmicrosoft.com","user017@wvdbootcamp.onmicrosoft.com","user018@wvdbootcamp.onmicrosoft.com","user019@wvdbootcamp.onmicrosoft.com","user020@wvdbootcamp.onmicrosoft.com","user021@wvdbootcamp.onmicrosoft.com","user022@wvdbootcamp.onmicrosoft.com","user023@wvdbootcamp.onmicrosoft.com","user024@wvdbootcamp.onmicrosoft.com","user025@wvdbootcamp.onmicrosoft.com","user026@wvdbootcamp.onmicrosoft.com","user027@wvdbootcamp.onmicrosoft.com","user028@wvdbootcamp.onmicrosoft.com","user029@wvdbootcamp.onmicrosoft.com","user030@wvdbootcamp.onmicrosoft.com","user031@wvdbootcamp.onmicrosoft.com","user032@wvdbootcamp.onmicrosoft.com","user033@wvdbootcamp.onmicrosoft.com","user034@wvdbootcamp.onmicrosoft.com","user035@wvdbootcamp.onmicrosoft.com","user036@wvdbootcamp.onmicrosoft.com","user037@wvdbootcamp.onmicrosoft.com","user038@wvdbootcamp.onmicrosoft.com","user039@wvdbootcamp.onmicrosoft.com","user040@wvdbootcamp.onmicrosoft.com","user041@wvdbootcamp.onmicrosoft.com","user042@wvdbootcamp.onmicrosoft.com","user043@wvdbootcamp.onmicrosoft.com","user044@wvdbootcamp.onmicrosoft.com","user045@wvdbootcamp.onmicrosoft.com","user046@wvdbootcamp.onmicrosoft.com","user047@wvdbootcamp.onmicrosoft.com","user048@wvdbootcamp.onmicrosoft.com","user049@wvdbootcamp.onmicrosoft.com","user050@wvdbootcamp.onmicrosoft.com","user051@wvdbootcamp.onmicrosoft.com","user052@wvdbootcamp.onmicrosoft.com","user053@wvdbootcamp.onmicrosoft.com","user054@wvdbootcamp.onmicrosoft.com","user055@wvdbootcamp.onmicrosoft.com","user056@wvdbootcamp.onmicrosoft.com","user057@wvdbootcamp.onmicrosoft.com","user058@wvdbootcamp.onmicrosoft.com","user059@wvdbootcamp.onmicrosoft.com","user060@wvdbootcamp.onmicrosoft.com","user061@wvdbootcamp.onmicrosoft.com","user062@wvdbootcamp.onmicrosoft.com","user063@wvdbootcamp.onmicrosoft.com","user064@wvdbootcamp.onmicrosoft.com","user065@wvdbootcamp.onmicrosoft.com","user066@wvdbootcamp.onmicrosoft.com","user067@wvdbootcamp.onmicrosoft.com","user068@wvdbootcamp.onmicrosoft.com","user069@wvdbootcamp.onmicrosoft.com","user070@wvdbootcamp.onmicrosoft.com","user071@wvdbootcamp.onmicrosoft.com","user072@wvdbootcamp.onmicrosoft.com","user073@wvdbootcamp.onmicrosoft.com","user074@wvdbootcamp.onmicrosoft.com","user075@wvdbootcamp.onmicrosoft.com","user076@wvdbootcamp.onmicrosoft.com","user077@wvdbootcamp.onmicrosoft.com","user078@wvdbootcamp.onmicrosoft.com","user079@wvdbootcamp.onmicrosoft.com","user080@wvdbootcamp.onmicrosoft.com","user081@wvdbootcamp.onmicrosoft.com","user082@wvdbootcamp.onmicrosoft.com","user083@wvdbootcamp.onmicrosoft.com","user084@wvdbootcamp.onmicrosoft.com","user085@wvdbootcamp.onmicrosoft.com","user086@wvdbootcamp.onmicrosoft.com","user087@wvdbootcamp.onmicrosoft.com","user088@wvdbootcamp.onmicrosoft.com","user089@wvdbootcamp.onmicrosoft.com","user090@wvdbootcamp.onmicrosoft.com","user091@wvdbootcamp.onmicrosoft.com","user092@wvdbootcamp.onmicrosoft.com","user093@wvdbootcamp.onmicrosoft.com","user094@wvdbootcamp.onmicrosoft.com","user095@wvdbootcamp.onmicrosoft.com","user096@wvdbootcamp.onmicrosoft.com","user097@wvdbootcamp.onmicrosoft.com","user098@wvdbootcamp.onmicrosoft.com","user099@wvdbootcamp.onmicrosoft.com","user100@wvdbootcamp.onmicrosoft.com","user101@wvdbootcamp.onmicrosoft.com","user102@wvdbootcamp.onmicrosoft.com","user103@wvdbootcamp.onmicrosoft.com","user104@wvdbootcamp.onmicrosoft.com","user105@wvdbootcamp.onmicrosoft.com","user106@wvdbootcamp.onmicrosoft.com","user107@wvdbootcamp.onmicrosoft.com","user108@wvdbootcamp.onmicrosoft.com","user109@wvdbootcamp.onmicrosoft.com","user110@wvdbootcamp.onmicrosoft.com","user111@wvdbootcamp.onmicrosoft.com","user112@wvdbootcamp.onmicrosoft.com","user113@wvdbootcamp.onmicrosoft.com","user114@wvdbootcamp.onmicrosoft.com","user115@wvdbootcamp.onmicrosoft.com","user116@wvdbootcamp.onmicrosoft.com","user117@wvdbootcamp.onmicrosoft.com","user118@wvdbootcamp.onmicrosoft.com","user119@wvdbootcamp.onmicrosoft.com","user120@wvdbootcamp.onmicrosoft.com","user121@wvdbootcamp.onmicrosoft.com","user122@wvdbootcamp.onmicrosoft.com","user123@wvdbootcamp.onmicrosoft.com","user124@wvdbootcamp.onmicrosoft.com","user125@wvdbootcamp.onmicrosoft.com","user126@wvdbootcamp.onmicrosoft.com","user127@wvdbootcamp.onmicrosoft.com","user128@wvdbootcamp.onmicrosoft.com","user129@wvdbootcamp.onmicrosoft.com","user130@wvdbootcamp.onmicrosoft.com","user131@wvdbootcamp.onmicrosoft.com","user132@wvdbootcamp.onmicrosoft.com","user133@wvdbootcamp.onmicrosoft.com","user134@wvdbootcamp.onmicrosoft.com","user135@wvdbootcamp.onmicrosoft.com","user136@wvdbootcamp.onmicrosoft.com","user137@wvdbootcamp.onmicrosoft.com","user138@wvdbootcamp.onmicrosoft.com","user139@wvdbootcamp.onmicrosoft.com","user140@wvdbootcamp.onmicrosoft.com","user141@wvdbootcamp.onmicrosoft.com","user142@wvdbootcamp.onmicrosoft.com","user143@wvdbootcamp.onmicrosoft.com","user144@wvdbootcamp.onmicrosoft.com","user145@wvdbootcamp.onmicrosoft.com","user146@wvdbootcamp.onmicrosoft.com","user147@wvdbootcamp.onmicrosoft.com","user148@wvdbootcamp.onmicrosoft.com","user149@wvdbootcamp.onmicrosoft.com","user150@wvdbootcamp.onmicrosoft.com","user151@wvdbootcamp.onmicrosoft.com","user152@wvdbootcamp.onmicrosoft.com","user153@wvdbootcamp.onmicrosoft.com","user154@wvdbootcamp.onmicrosoft.com","user155@wvdbootcamp.onmicrosoft.com","user156@wvdbootcamp.onmicrosoft.com","user157@wvdbootcamp.onmicrosoft.com","user158@wvdbootcamp.onmicrosoft.com","user159@wvdbootcamp.onmicrosoft.com","user160@wvdbootcamp.onmicrosoft.com","user161@wvdbootcamp.onmicrosoft.com","user162@wvdbootcamp.onmicrosoft.com","user163@wvdbootcamp.onmicrosoft.com","user164@wvdbootcamp.onmicrosoft.com","user165@wvdbootcamp.onmicrosoft.com","user166@wvdbootcamp.onmicrosoft.com","user167@wvdbootcamp.onmicrosoft.com","user168@wvdbootcamp.onmicrosoft.com","user169@wvdbootcamp.onmicrosoft.com","user170@wvdbootcamp.onmicrosoft.com","user171@wvdbootcamp.onmicrosoft.com","user172@wvdbootcamp.onmicrosoft.com","user173@wvdbootcamp.onmicrosoft.com","user174@wvdbootcamp.onmicrosoft.com","user175@wvdbootcamp.onmicrosoft.com","user176@wvdbootcamp.onmicrosoft.com","user177@wvdbootcamp.onmicrosoft.com","user178@wvdbootcamp.onmicrosoft.com","user179@wvdbootcamp.onmicrosoft.com","user180@wvdbootcamp.onmicrosoft.com","user181@wvdbootcamp.onmicrosoft.com","user182@wvdbootcamp.onmicrosoft.com","user183@wvdbootcamp.onmicrosoft.com","user184@wvdbootcamp.onmicrosoft.com","user185@wvdbootcamp.onmicrosoft.com","user186@wvdbootcamp.onmicrosoft.com","user187@wvdbootcamp.onmicrosoft.com","user188@wvdbootcamp.onmicrosoft.com","user189@wvdbootcamp.onmicrosoft.com","user190@wvdbootcamp.onmicrosoft.com","user191@wvdbootcamp.onmicrosoft.com","user192@wvdbootcamp.onmicrosoft.com","user193@wvdbootcamp.onmicrosoft.com","user194@wvdbootcamp.onmicrosoft.com","user195@wvdbootcamp.onmicrosoft.com","user196@wvdbootcamp.onmicrosoft.com","user197@wvdbootcamp.onmicrosoft.com","user198@wvdbootcamp.onmicrosoft.com","user199@wvdbootcamp.onmicrosoft.com","user200@wvdbootcamp.onmicrosoft.com","user201@wvdbootcamp.onmicrosoft.com","user202@wvdbootcamp.onmicrosoft.com","user203@wvdbootcamp.onmicrosoft.com","user204@wvdbootcamp.onmicrosoft.com","user205@wvdbootcamp.onmicrosoft.com","user206@wvdbootcamp.onmicrosoft.com","user207@wvdbootcamp.onmicrosoft.com","user208@wvdbootcamp.onmicrosoft.com","user209@wvdbootcamp.onmicrosoft.com","user210@wvdbootcamp.onmicrosoft.com"
foreach ($user in $userArray) {
    Remove-MsolUser -UserPrincipalName $user -Force
}

Connect-AzureAD	# 
Get-AzureADUser 
