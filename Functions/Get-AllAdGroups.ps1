function Get-AllADGroups([string]$username) {
    get-aduser $username -properties memberof | select-object -ExpandProperty memberof | Get-ADGroup -Properties name | select-object name | sort-object name
}