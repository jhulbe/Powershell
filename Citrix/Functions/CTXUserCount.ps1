##Example, running "ctxusers" gets the user count across all farms.
## Add this alias to your Powershell profile
#alias for usersscript

new-item alias:ctxusers -value ".\citrixsessions.ps1"

##CitrixSessions.ps1 is 

$Farm1 = Server1.domain.com
$farm2 = Server2.domain.com
$Farm3 = Server3.domain.com

$Farm1Active = (Get-XASession -computername $Farm1 | ? { $_.Protocol -eq "ICA" -and $_.State -eq "Active"}).Count
$Farm1Disconnected = (Get-XASession -computername $Farm1 | ? { $_.Protocol -eq "ICA" -and $_.State -eq "Disconnected"}).Count
$Farm2Active = (Get-XASession -computername $Farm2 | ? { $_.Protocol -eq "ICA" -and $_.State -eq "Active"}).Count
$Farm2Disconnected = (Get-XASession -computername $Farm2 | ? { $_.Protocol -eq "ICA" -and $_.State -eq "Disconnected"}).Count
$Farm3Active = (Get-XASession -computername $Farm3 | ? { $_.Protocol -eq "ICA" -and $_.State -eq "Active"}).Count
$Farm3Disconnected = (Get-XASession -computername $Farm3 | ? { $_.Protocol -eq "ICA" -and $_.State -eq "Disconnected"}).Count
$Farm1Total = ([int]$Farm1Active + [int]$Farm1Disconnected)
$Farm2Total = ([int]$Farm2Active + [int]$Farm2Disconnected)
$Farm3Total = ([int]$Farm3Active + [int]$Farm3Disconnected)
$AllFarms = ([int]$Farm1Total + [int]$Farm2Total + [int]$Farm3Total)
$date = Get-date
write-host "

$date

All Farms
------------------------
$AllFarms

Farm1 Total Sessions
------------------------
$Farm1Total ($Farm1Disconnected Disconnected)

Farm2 Total Sessions
------------------------
$Farm2Total ($Farm2Disconnected Disconnected)

Farm3 Total Sessions
------------------------
$Farm3Total ($Farm3Disconnected Disconnected)

"

