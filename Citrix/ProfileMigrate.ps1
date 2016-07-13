#Checks that H:\profileswitch exist, if it does it restores information to the user profile, if it doesn't it backs it up. Backups up recent items in office products, email signatures, firefox bookmarks. 

$UserDrive = 'H:\profileswitch'
$FileExists = test-path $UserDrive
$path = $env:APPDATA
$user = $env:USERNAME
$profile = Get-ChildItem "$env:APPDATA\mozilla\firefox\Profiles" | Sort-Object LastAccessTime -Descending | Select-Object -First 1 -expandproperty FullName 

If ($FileExists -eq $true) {
$items = Get-ChildItem -Path "$UserDrive" -Recurse -include *.reg
Write-host "$UserDrive Exists - Restoring settings from H:\ to Citrix Profile" -ForegroundColor Yellow 

Write-host "----------         Restoring Signature Files          ----------" -ForegroundColor Yellow 
xcopy $UserDrive\Signatures\*.* $path\Microsoft\Signatures\ /S /E /F /Y /Q

Write-host "----------           Restoring Recent Files           ----------" -ForegroundColor Yellow 
xcopy $UserDrive\Recent\*.* $path\Microsoft\Office\Recent\ /S /E /F /Y /Q

Write-host "----------           Restoring FireFox Profile        ----------" -ForegroundColor Yellow 
Copy-Item $UserDrive\firefoxprofile\ -Recurse -Destination "$profile\bookmarkbackups\"

Write-Host "----------   Setting Recent items in Office Products  ----------" -ForegroundColor Yellow 

foreach ($item in $items){
Write-host "importing $item"
reg.exe import $item
}

Write-host "----------       Removing ProfileSwitch paths      ----------" -ForegroundColor Yellow
## remove-item $UserDrive\ -recurse -ErrorAction SilentlyContinue
Write-Host "Completed" -ForegroundColor Yellow
}


else{
Write-host "$UserDrive doesn't exists - Backingup settings to $UserDrive" -ForegroundColor Yellow
New-Item -ItemType directory -Path $UserDrive -ErrorAction SilentlyContinue
New-Item -ItemType directory -Path $UserDrive\firefoxprofile -ErrorAction SilentlyContinue
New-Item -ItemType directory -Path $UserDrive\Signatures -ErrorAction SilentlyContinue
New-Item -ItemType directory -Path $UserDrive\Recent -ErrorAction SilentlyContinue
$keys = 'HKCU\Software\Microsoft\Office\14.0\Word\File MRU', 'HKCU\Software\Microsoft\Office\14.0\Excel\File MRU', 'HKCU\Software\Microsoft\Office\14.0\PowerPoint\File MRU', 'HKCU\Software\Microsoft\Office\14.0\Access\File MRU', 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist', 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths'
$keys | % {
  $i++
  & reg export $_ "$UserDrive\$i.reg" /Y
}
Copy-item "$profile\bookmarkbackups\*.*" -recurse -destination $UserDrive\firefoxprofile\
Copy-item $path\Microsoft\Signatures\*.* -recurse -destination $UserDrive\Signatures\ 
Copy-item $path\Microsoft\Office\Recent\*.* -recurse -destination $UserDrive\Recent\ 
}