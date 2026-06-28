. .\Globals.ps1
. .\Methods.ps1

$ModPath = Join-Path $Paths.Downloads "mods"
$Formats.Mods = @(".ttmp2",".pmp")

# # ----------------------------------------
# # Archive Extraction
# # ----------------y------------------------
# New-Item -ItemType Directory -Path $ModPath
# Extract-Archives $Paths.Downloads $ModPath -UseFolder

# # ----------------------------------------
# # Rename Folders
# # ----------------------------------------
# Get-ChildItem -LiteralPath $ModPath -File |
#     Where-Object {
#         $_.Name.Contains("mods - ")
#     } |
#     ForEach-Object {
#         $NewName = $_.Name -replace "mods -", ""
#         Rename-Item -LiteralPath $_.FullName $NewName
#     }

# Get-ChildItem -LiteralPath $ModPath -Directory |
#     Where-Object {
#         $_.Name -notmatch "alee"
#     } |
#     ForEach-Object {
#         $NewName = "[alee] $($_.Name)"
#         Rename-Item -LiteralPath $_.FullName $NewName
#     }

# # ----------------------------------------
# # Rename Files
# # ----------------------------------------
# Get-ChildItem -LiteralPath $Paths.Downloads -Directory |
# ForEach-Object {

#     $Mod = $_

#     Get-ChildItem -LiteralPath $Mod.FullName -File |
#     Where-Object {
#         $_.Extension -in ".ttmp2", ".pmp"
#     } |
#     ForEach-Object {

#         $File = $_
#         $Tag = $null

#         if (-not $File.Name.StartsWith($Mod.Name)) {

#             if ($File.Name -match "muse") {
#                 $Tag = "Muse"
#             }
#             elseif ($File.Name -match "bimbo") {
#                 $Tag = "Bimbo"
#             }
#             elseif ($File.Name -match "lavabod|lava") {
#                 $Tag = "LavaBod"
#             }
#             elseif ($File.Name -match "yet[-_\s]*another|yab") {
#                 $Tag = "YAB"
#             }
#             elseif ($File.Name -match "tre") {
#                 $Tag = "Tre"
#             }

#             if ($Tag) {
#                 $NewName = "$($Mod.Name) - $Tag$($File.Extension)"
#             }
#             else {
#                 $NewName = "$($Mod.Name) - $($File.Name)"
#             }

#             Write-Host "$($File.Name) -> $NewName"

#             Rename-Item -LiteralPath $File.FullName -NewName $NewName
#         }
#     }
# }

# # ----------------------------------------
# # Flatten Folder
# # ----------------------------------------
# Flatten-Folder $ModPath

# # ----------------------------------------
# # Move Standalones
# # ----------------------------------------
# $Backup = "C:\Users\Leo\Desktop\Backup" 
# $Mods = "C:\Users\Leo\Downloads\mods"
# Get-ChildItem -LiteralPath $Backup |
#     ForEach-Object{
#         Move-Item -LiteralPath $_.FullName -Destination $Mods
#     }


# # ----------------------------------------
# # Remove Undesirables
# # ----------------------------------------
# Get-ChildItem -LiteralPath $ModPath -File |
# Where-Object {
#     $_.Name -match ' rue| tre| muse'
# } |
# ForEach-Object {
#     Remove-Item -LiteralPath $_.FullName
# }

# # ----------------------------------------
# # Rename Episode Numbers
# # ----------------------------------------
# $VidPath = Join-Path D: Media "TV Shows" "Yu Yu Hakusho (1992)" "Season 04 [1080p x265 AAC]"

# Get-ChildItem -LiteralPath $VidPath -File |
# ForEach-Object {

#     $NewName = $_.Name -replace '\d{3}(?=\.[^.]+$)', {
#         'S04E{0:D2}' -f ([int]$_.Value - 94)
#     }

#     Rename-Item -LiteralPath $_.FullName -NewName $NewName
# }