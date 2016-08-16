<#
Search profiles of all 3 farms, and delete a published shortcut off users desktops. 
#>

$location1 = "\\fileserv01.domain.com\user_data1$"
$location2 = "\\fileserv02.domain.com\user_data1$"
$location3 = "\\fileserv03.domain.com\user_data1$"

gci $location1 -recurse -ErrorAction SilentlyContinue | where-object {$_.name -like "Internet Explorer 11.ica"} | Remove-item
gci $location2 -recurse -ErrorAction SilentlyContinue | where-object {$_.name -like "Internet Explorer 11.ica"} | Remove-item
gci $location3 -recurse -ErrorAction SilentlyContinue | where-object {$_.name -like "Internet Explorer 11.ica"} | Remove-item