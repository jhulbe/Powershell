<#
Define Datastores as an array, randomly grab one. Then define VM Names. Take that info, create a VM from template in the citrix cluster on a random datastore. Then list the mac address. 
The mac address goes into a script to create DHCP Leases and Citrix PVS machine accounts
#>

$DATASTOREARRAY = 'VM_FC_SSD_Citrix03','VM_FC_SSD_Citrix04','VM_FC_SSD_Citrix05','VM_FC_SSD_Citrix06'
$DATASTORE = $DATASTOREARRAY[(Get-Random -Maximum ([array]$DATASTOREARRAY).count)]
$VMS = (get-content “c:\scripts\citrix\deploy.txt")

foreach ($VM in $VMs)
{
New-VM -Name $VM -Template CTX_template -Datastore $DATASTORE -resourcepool (get-cluster CITRIX)
}

foreach ($VM in get-content “c:\scripts\citrix\deploy.txt”)
{
Get-NetworkAdapter -vm $VM | select MacAddress
}
