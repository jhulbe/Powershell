#custom lookups for processes
function Kill-CTXProcess([string]$process){
foreach ($system in get-content ".\systems.txt")
 {get-wmiobject -computername $system win32_process|where{$_.name -eq "$process"}|Foreach-Object {$_.Terminate()}}
}

#Example "Kill-CTXProcess kazaa.exe" would kill every kazaa.exe in every PC in Systems.txt