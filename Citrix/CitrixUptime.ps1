$Servers = qfarm /online | select servername -expandproperty servername -erroraction SilentlyContinue

foreach($Server in $Servers)

{

$wmi = Get-WmiObject -class Win32_OperatingSystem -computer $server

$LBTime = $wmi.ConvertToDateTime($wmi.Lastbootuptime)

[TimeSpan]$uptime = New-TimeSpan $LBTime $(get-date)

write-output ""PC" $($server) “Uptime:” $($uptime.days) “Days” $($uptime.hours) “Hours” $($uptime.minutes) “Minutes” $($uptime.seconds) “Seconds”"

}

