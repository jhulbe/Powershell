#Snippet of code from a deployment script that grabs the mac addresses from newly created VMs to import into a DHCP Reservation code. 

$VM = Get-content .\systems.txt
$mac = (Get-NetworkAdapter -vm $vm).MacAddress 
format-list
write-host ($mac -replace(":","")) 
