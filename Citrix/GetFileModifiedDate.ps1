<#
#>

$profilenames = get-childitem \\server\user_profile$ | select name -ExpandProperty name | Sort-Object name
foreach ($profile in $profilenames){Write-host $profile @(get-itemproperty \\server\user_profile$\$profile\UPM_Profile\NTUSER.dat -ErrorAction SilentlyContinue).lastwritetime;}
