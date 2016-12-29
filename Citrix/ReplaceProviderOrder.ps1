<#
Having weird issues with freezes, locks ups, apps not loading, apps prompting for a windows login after opening. Moving PnSson up on the provider order above webclient seemed to help
This script grabs the current provider order, deletes PnSson, adds it in front of webclient. It writes host the PC name, original order, and changed order for a clean start-transcript log of what is changed.
#>

$PCS = Get-Content C:\scripts\pclist.txt
foreach ($PC in $PCS){
$var1 = invoke-command -cn $PC -ScriptBlock {(get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order' -Name ProviderOrder).ProviderOrder}
write-host $PC
Write-host BEFORE $var1
$var2 = $var1 -replace ",PnSson", ""
$var3 = $var2 -replace ",WebClient", ",PnSson,WebClient"
invoke-command -cn $PC -ArgumentList $var3 -ScriptBlock  {set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order' -Name ProviderOrder -value $args[0]}
$var4 = invoke-command -cn $PC -ScriptBlock {(get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider\Order' -Name ProviderOrder).ProviderOrder}
write-host AFTER $var4
}