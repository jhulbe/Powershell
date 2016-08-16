function Get-Sid([string]$username) {
    Get-ADuser $username -properties * | Select sid
    }
