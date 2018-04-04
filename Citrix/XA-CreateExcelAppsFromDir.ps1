<#
This script was created to recreate all exsisting excel apps into the 7.x citrix farm. 
The ExcelApps folder is local on every machine, and the folder name is the application name
I grabbed the local copy names and created the app in citrix, and then I grabbed the permission on the start menu share and applied that to the app in citrix. 
#>

$AppName = (gci C:\EXCELAPPS).fullname

        #BUILD ALL THE PROPERTIES FROM THE NEW-BROKERAPPLICATION COMMAND ONE APP AT A TIME

Foreach ($App in $Appname){

        $ShortName = ($App).replace("C:\EXCELAPPS\","")
        $PublishedName = "Excel-$ShortName"
        $Name = ($App).replace("C:\EXCELAPPS\","Excel Apps\")
        $WorkingDirectory = ($App).replace("C:","%SystemDrive%")
        $CLE = (gci $App -recurse | Where{($_.fullname -like "*.cmd") -or ($_.fullname -like "*.bat")}).fullname.replace("C:","%SystemDrive%")
        $AdminFolder = "Excel Apps\"
        $CF = "Excel Apps"

Write-host Creating $ShortName -ForegroundColor Cyan

        #CREATE THE APP

New-BrokerApplication `
-Name $PublishedName `
-CommandLineExecutable $CLE `
-DesktopGroup "US-DESKTOPS=" `
-AdminFolder $AdminFolder `
-ApplicationType "HostedOnDesktop" `
-BrowserName $PublishedName `
-ClientFolder "Excel Apps" `
-Enabled $True `
-IconUid 10 `
-PublishedName $PublishedName `
-ShortcutAddedToDesktop $False `
-ShortcutAddedToStartMenu $False `
-UserFilterEnabled $true `
-Visible $True `
-WorkingDirectory $WorkingDirectory | out-null

Write-host "Adding Permissions"         

          #MATCH THE PERMISSIONS ON THE START MENU TO THE APP, GATHER LIST OF USERS AND GROUPS

$Groups = gci \\netapp\ctxusershare\Start\ExcelApps `
| ?{$_.name -like "*$shortname*"}`
| Get-ntfsaccess `
| ?{($_.account -like "DOMAIN\*") -and ($_.account -notlike "*CITRIX_ADMINS*")} 

        Foreach($G in $Groups){
                $Shortgroup = $G.account
                $PERMGROUP = $shortgroup -replace [Regex]::Escape("DOMAIN\"),""

          #CHECK IF IT’S A USER OR A GROUP, ADD ALL USERS OF GROUPS OR JUST THE USER

                foreach ($User in $PERMGROUP) { 
                        try { 
                                Get-ADUser -Identity $User | Out-Null 
                                Add-BrokerUser -Name $User -Application "Excel Apps\$PublishedName"
                                } 
                        catch { 
                                Get-adgroupMember $PERMGROUP | %{Add-BrokerUser -Name $_.samaccountname -Application "Excel Apps\$PublishedName"} 
                                } 
                                                } 
          #ADD CITRIX_ADMINS

                                add-brokeruser -Name DOMAIN\CITRIX_ADMINS -Application "Excel Apps\$PublishedName"
                                }
          #HAD TO ADD A SMALL SLEEP BETWEEN EACH APP OR IT IMPLODES LIKE THE DEATHSTAR, IT’S JUST TOO FAST

sleep 1
}
