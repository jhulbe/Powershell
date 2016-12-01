taskkill /F /FI "USERNAME eq %username%" /IM explorer.exe
regedit /s .\bottomreset.reg
start explorer.exe