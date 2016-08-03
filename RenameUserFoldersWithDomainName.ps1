Get-ChildItem \\server\share\users -Filter “*.domain1” | Rename-Item -NewName {$_.name -replace '.domain1’,’.domain2’ }


Get-ChildItem \\server\share\users -Filter “*.domain2” | Rename-Item -NewName {$_.name -replace '.domain2’,’.domain1’ }


# example
# Replaces domain name in user shared folders from user.domain1 to user.domain2
# Used when migrating domains and keeping the redirected folders the same.
#
# to test with just one folder instead of a whole directory is:
#
# Get-Item \\server\share\users\user1.domain1 | rename-item -newname {$_.name -replace '.domain1','.domain2'}
#
#
#
