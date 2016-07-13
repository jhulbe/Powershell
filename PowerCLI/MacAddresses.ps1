$VM = Get-content .\systems.txt
$mac = (Get-NetworkAdapter -vm $vm).MacAddress 
format-list
write-host ($mac -replace(":","")) 
