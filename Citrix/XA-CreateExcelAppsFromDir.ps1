$AppName = (gci C:\ExcelApps).fullname

Foreach ($App in $Appname){

  $ShortName = ($App).replace("C:\ExcelApps\","")
  $PublishedName = "Excel-$ShortName"
  $WorkingDirectory = ($App).replace("C:","%SystemDrive%")
  $CLE = (gci $App -recurse | Where{($_.fullname -like "*.cmd") -or ($_.fullname -like "*.bat")}).fullname.replace("C:","%SystemDrive%")
  $AdminFolder = "Excel Apps\"
  $CF = "Excel Apps"

          Write-host $PublishedName -ForegroundColor Yellow

New-BrokerApplication `
-Name $PublishedName `
-CommandLineExecutable $CLE `
-DesktopGroup "US-Desktops" `
-AdminFolder $AdminFolder `
-ApplicationType "HostedOnDesktop" `
-BrowserName $PublishedName `
-ClientFolder "$CF" `
-Enabled $True `
-IconUid 10 `
-PublishedName $PublishedName `
-ShortcutAddedToDesktop $False `
-ShortcutAddedToStartMenu $False `
-UserFilterEnabled $true `
-Visible $True `
-WorkingDirectory $WorkingDirectory 

           sleep 10
}
