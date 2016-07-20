#using foreach, and a txt list of pcs and users, not csv
$PCS = get-content "c:\scripts\PCLIST.txt"
$PATHS = get-content "C:\scripts\username.txt"
#loop through pcs
ForEach ($PC in $PCS) {
    #loop through paths
    foreach($path in $paths){
        #inside, $pc is the individual PC, $path is the individual path...
        #You might need to modify the syntax of 'copy' depending on what you are trying to do.
        copy "\\$PC\C$\Documents and Settings\$PATH.cfins\Desktop\*" "\\servername\users\$PATH\Desktop\" -recurse -force
        copy "\\$PC\C$\Documents and Settings\$PATH.cfins\Favorites\*" "\\servername\users\$PATH\Favorites\" -recurse -force       
        copy "\\$PC\C$\Documents and Settings\$PATH.cfins\My Documents\*" "\\servername\users\$PATH\My Documents\" -recurse -force
        copy "\\$PC\C$\Documents and Settings\$PATH\Desktop\*" "\\servername\users\$PATH\Desktop\" -recurse -force
        copy "\\$PC\C$\Documents and Settings\$PATH\Favorites\*" "\\servername\users\$PATH\Favorites\" -recurse -force       
        copy "\\$PC\C$\Documents and Settings\$PATH\My Documents\*" "\\servername\users\$PATH\My Documents\" -recurse -force
        copy "\\$PC\C$\Users\$PATH.cfins\Desktop\*" "\\servername\users\$PATH\Desktop\" -recurse -force
        copy "\\$PC\C$\Users\$PATH.cfins\Favorites\*" "\\servername\users\$PATH\Favorites\" -recurse -force       
        copy "\\$PC\C$\Users\$PATH.cfins\My Documents\*" "\\servername\users\$PATH\My Documents\" -recurse -force
        copy "\\$PC\C$\Users\$PATH\Desktop\*" "\\servername\users\$PATH\Desktop\" -recurse -force
        copy "\\$PC\C$\Users\$PATH\Favorites\*" "\\servername\users\$PATH\Favorites\" -recurse -force       
        copy "\\$PC\C$\Users\$PATH\My Documents\*" "\\servername\users\$PATH\My Documents\" -recurse -force
    }
}

