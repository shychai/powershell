. .\Globals.ps1
. .\Methods.ps1

# ----------------------------------------
# Extract Downloads Archives
# ----------------------------------------
Extract-Archives $Paths.Downloads
Remove-FilesByFormat $Paths.Downloads $Formats.Archives