<#
Grabs a user ID and tells me where they're logged in on our citrix farm.
#>

function whois([string]$name) {
Get-XASession -computername $Datacollector | where-object {$_.accountname -like "domain\$name"}
}
