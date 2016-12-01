taskkill /F /FI "USERNAME eq %username%" /IM explorer.exe
regedit /s  .\topreset.reg
start explorer.exe