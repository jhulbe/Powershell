$VMS = Get-Content .\systems.txt
foreach ($VM in $VMS){Get-VM $VM | Shutdown-VMGuest -Confirm:$False}
foreach ($VM in $VMS){Get-VM $VM | Set-VM -memorygb 24 -Confirm:$False}
foreach ($VM in $VMS){Start-VM $VM}