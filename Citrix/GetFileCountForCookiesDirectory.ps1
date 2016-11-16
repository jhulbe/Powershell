##Example Grabs the subdirectores in the user_ctx_profile$ path and then looks in each profile for the cookies and then list the number of files in each profile. 

$profilenames = @(get-childitem \\server\user_ctx_profile$ | sort-object name | select -ExpandProperty name );
foreach ($profile in $profilenames){Write-host $profile (get-childitem \\server\user_ctx_profile$\$profile\UPM_Profile\AppData\Roaming\Microsoft\Windows\Cookies -ErrorAction SilentlyContinue).count}
