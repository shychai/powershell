function Get-FilesByFormat {
    param(
        [string]$Path,
        [string[]]$Formats
    )

    Get-ChildItem $Path -File | Where-Object {
        $_.Extension -in $Formats
        }
}

function Extract-Archive {
    param(
        [string]$ArchivePath,
        [string]$Destination,
        [switch]$UseFolder
    )

    if (Test-Path -LiteralPath $ArchivePath -PathType Leaf) {
        
        $LeafBase = Split-Path $ArchivePath -LeafBase

        if ($Destination) {
            New-Item -ItemType Directory -Path $OutputPath
            $Parent = $Destination
        }
        else {
            $Parent = Split-Path $ArchivePath -Parent
        }
        
        if ($UseFolder) {
            $OutputPath = Join-Path $Parent $LeafBase
        }
        else {
            $OutputPath = $Parent
        }

        & $Tools.SevZip x $ArchivePath "-o$OutputPath" -y
    }

    elseif (Test-Path -LiteralPath $ArchivePath -PathType Container) {
        Get-ChildItem -LiteralPath $ArchivePath -File -Recurse |
        Where-Object {
            $_.Extension -in $Formats.Archives
        } |
        ForEach-Object {
            Extract-Archive $_.FullName -Destination:$Destination -UseFolder:$UseFolder
        }
    }
    else {
        Write-Host "Path not found: $ArchivePath"
    }
}