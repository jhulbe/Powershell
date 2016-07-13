
function whosin([string]$dcs) {
    Get-ADGroupMember "$dcs" | Select name | sort-object name
}