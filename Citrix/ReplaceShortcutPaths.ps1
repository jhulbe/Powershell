#Example, I had a need to replace a bunch of shortcuts that called C:\program filesx86 with an enviromental variable %CFFP% that called either x86 or 64 bit path based on the version of office installed. 
#This helped replace hundreds of shortcuts that called excel sheets, or access databases. It made them work on 64bit or 32bit office. 

# Call wscript com object
$shell = new-object -com wscript.shell
# Recurse through directories for .lnk files

$rdir = C:\PathHere\

dir "$rdir" -filter *.lnk -recurse | foreach {
$lnk = $shell.createShortcut($_.fullname)
$oldPath= $lnk.targetPath
# If match text, perform operation
if($oldpath -match "Program Files")
{
write-host "Match: " + $_.fullname
remove-item $_.fullname
$lnknew = $shell.createShortcut($_.fullname)
$lnknew.targetPath = "C:\%CFPF%\" + $_.fullname
$lnknew.WorkingDirectory = "C:\%CFPF%\Microsoft Office\Office14"
$lnknew.IconLocation = "%SystemRoot%\system32\SHELL32.dll,4"
$lnknew.Save()
}
}
Write-Host "End..."