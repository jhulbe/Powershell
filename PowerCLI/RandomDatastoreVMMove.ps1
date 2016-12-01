<#
Command moves everything in old datastores to new datastores by randomly choosing the new data store name from the array. 
#>


$SERVERS = Get-Datastore | Where {$_.Name -like "nim-citrix*"} | Get-VM | Select Name -ExpandProperty name
$DATASTOREARRAY = 'FC_SSD_Citrix03','FC_SSD_Citrix04','FC_SSD_Citrix05','_FC_SSD_Citrix06'
$DATASTORE = $DATASTOREARRAY[(Get-Random -Maximum ([array]$DATASTOREARRAY).count)]

Foreach($Server in $Servers){
Write-host "Moving $SERVER to $Datastore"
Move-VM $Server -Datastore $DATASTORE
}
