<#
Search profiles of all 3 farms, and delete a published shortcut off users desktops. Excludes the Source directory  called SourceDIR for icons. 
#>

$location1 = "\\fileserv01.domain.com\user_data1$" | sort fullname | ? {$_.name -notlike "SourceDIR"}).fullname
$location2 = "\\fileserv02.domain.com\user_data1$" | sort fullname | ? {$_.name -notlike "SourceDIR"}).fullname
$location3 = "\\fileserv03.domain.com\user_data1$" | sort fullname | ? {$_.name -notlike "SourceDIR"}).fullname

gci $location1 -depth 2 -recurse -ErrorAction SilentlyContinue | where-object {$_.name -like "Internet Explorer 11.ica"} | Remove-item -verbose
gci $location2 -depth 2 -recurse -ErrorAction SilentlyContinue | where-object {$_.name -like "Internet Explorer 11.ica"} | Remove-item -verbose
gci $location3 -depth 2 -recurse -ErrorAction SilentlyContinue | where-object {$_.name -like "Internet Explorer 11.ica"} | Remove-item -verbose
