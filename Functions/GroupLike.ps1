function GroupLike([string]$name) {
   Get-ADGroup -Filter "name -like '*$name*'" -Properties * | select Name,Description | Sort-object Name
}
