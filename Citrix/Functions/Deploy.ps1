#Example, "Deploy C:\testfolder\testfile.cmd" would copy that file to the same path on every box in the citrix farm. 
#Useful for quickly deploying a reg file, ini file, or config changes that need pushed. 


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