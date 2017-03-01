#Copies a file to all users firefox profiles in a roaming profiles directory

$Dirs = (gci \\server\user_citrix_profile$).name
$profiles = foreach($dir in $dirs){gci \\server\user_citrix_profile$\$dir\UPM_Profile\AppData\Roaming\Mozilla\Firefox\Profiles -ErrorAction SilentlyContinue}
foreach($profile in $profiles){
copy-item \\server\share\test\test.txt ($profile).fullname -whatif
}
