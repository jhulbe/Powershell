<#
This grabs a list of servers, queries the processor affinity for "sfc" which is sourcefire, and then sets it to Affinity 8.
Depending on how many cores your PC has, will determine your affinity Hex/Decimal value. I recommmend changing one manually to what you want and then doing a get-process | select processoraffinity

Becareful of using this, it could imbalaces the CPU cycles on VMs. 
I used this a temp patch until I could figure out why my Sourcefire was scanning so much. 
#>

Foreach($server in get-content “.\systems.txt”){
invoke-command -cn $server {get-process sfc | select ProcessorAffinity}
invoke-command -cn $server {$process = get-process sfc; $process.ProcessorAffinity=8}
invoke-command -cn $server {get-process sfc | select ProcessorAffinity}
}