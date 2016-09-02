<#
#>

function NameLike([string]$name) {
   Get-ADUser -Filter "name -like '*$name*'" -Properties Name,SamAccountName | Select Name,SamAccountName | Sort-object Name
}