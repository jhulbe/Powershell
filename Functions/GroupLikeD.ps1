<#
 function searches for a group and then list all matching groups with the Description included.
 similar to grouplike function, but includes the description. 

 Ex. GrouplikeD citrix 

 gives all the AD groups with Citrix in the name.
 #>

function GroupLikeD([string]$name) {
   Get-ADGroup -Filter "name -like '*$name*'" -Properties * | select Name,Description | Sort-object Description
}