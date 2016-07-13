function Get-CTXProcess([string]$process){
foreach ($system in get-content ".\systems.txt")
 {
get-wmiobject -computername $system win32_process|where{$_.name -eq "$process"}|select CSName,name,@{n="owner";e={$_.getowner().user}}}
 }

#Example "Get-CTXProcess Outlook.exe" would tell me everyone running Outlook.exe on every system in system.txt