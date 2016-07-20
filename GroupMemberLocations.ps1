#Example, this helped me list all users in a group and what office they were in. 

$groupname = GROUP_NAME_HERE
$user = get-adgroupmember $groupname | select SamAccountName
foreach ($user in $users)
{
Get-Aduser -identity "$user" -properties * | select SamAccountname,Office
}