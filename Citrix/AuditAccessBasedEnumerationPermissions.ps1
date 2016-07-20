#Example of perms.csv is an export of get-ntfsaccess command from the NTFS Security Module. 
#This is used to edit permissions, run an export, clean up the entries, then run this to apply the access needed. 
#
# Path	                                                                    Account
# \\servername\ctx_start$\Files\Shortcut\links\ACL.ica	                    DOMAIN\Citrix-ACL
# \\servername\ctx_start$\Files\Shortcut\links\Adobe Acrobat X Pro.ica	    DOMAIN\CTX-AdobeAcrobat-Pro
# \\servername\ctx_start$\Files\Shortcut\links\Adobe Acrobat X Standard.lnk	DOMAIN\CTX-Environmental-Desktop
#
#

$rows = Import-Csv -Path C:\scripts\citrix\perms.csv

ForEach($row in $rows){
    Add-NTFSAccess -PassThru $row.Path -Account $row.Account -AccessRights ReadAndExecute, Synchronize
}