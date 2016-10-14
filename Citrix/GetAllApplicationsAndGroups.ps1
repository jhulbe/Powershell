<#
Set your Datacollect name, this grabs all your applications and the configured users
#>
$datacollector = 
Get-XAApplicationReport -computername $datacollector *| Select Browsername,Accounts | Sort Browsername