<# 
Get Citrix Servers with zero load with the command "zeroload"
#>

function ZeroLoad
{
get-xaserverload -computername $datacollector | sort-object servername | where {$_.load -like '0'}
}