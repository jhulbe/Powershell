#Upgrading VMs from 16 to 24GB, used this 

$VMS = Get-Content .\systems.txt
foreach ($VM in $VMS){
Get-VM $VM | Shutdown-VMGuest -Confirm:$False
Get-VM $VM | Set-VM -memorygb 24 -Confirm:$False
Start-VM $VM
}
