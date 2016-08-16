<#
Gets the time stamp on the ntuser.dat for all profiles in the UPM profile directory. Lets me know which profiles I can delete because the ntuser.dat hasn't been modified in awhile.
#>


$profilenames = get-childitem \\filesrv01.cfins.com\user_ctx_profile$ | select name -ExpandProperty name | Sort-Object name
foreach ($profile in $profilenames){Write-host $profile @(get-itemproperty \\filesrv01.cfins.com\user_ctx_profile$\$profile\UPM_Profile\NTUSER.dat -ErrorAction SilentlyContinue).lastwritetime;}
