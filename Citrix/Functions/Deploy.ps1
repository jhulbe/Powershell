function Deploy{
    Param([string]$file)
   $servers = qfarm /online | select servername

foreach ($server in $servers) 
{
copy-item -path $file -Destination "\\$server\$($file.replace(":", "$"))" -recurse -force -PassThru -ErrorAction silentlyContinue
if ($server) { $server }
else {"Copy failure"} 
  }
 }

## Example "Deploy D:\startupscript\startup.cmd" would deploy startup.cmd to all online servers in the farm. 