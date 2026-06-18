function Get-FilesByFormat {
    param(
        [string]$Path,
        [string[]]$Formats
    )

    Get-ChildItem $Path | Where-Object {
        $_.Extension -in $Formats
        }
}

function Extract-Archive {
    param(
        [string]$ArchivePath,
        [switch]$UseFolder
    )

    if (Test-Path -LiteralPath $ArchivePath -PathType Leaf) {
        $Item = Get-Item -LiteralPath $ArchivePath

        $Parent = $Item.DirectoryName
        $LeafBase = [System.IO.Path]::GetFileNameWithoutExtension($Item.Name)

        if ($UseFolder) {
            $OutputPath = Join-Path $Parent $LeafBase
        }
        else {
            $OutputPath = $Parent
        }

        & $Tools.SevZip x $Item.FullName "-o$OutputPath" -y
    }

    elseif (Test-Path -LiteralPath $ArchivePath -PathType Container) {
        Get-ChildItem -LiteralPath $ArchivePath -File -Recurse |
        Where-Object {
            $_.Extension -in $Formats.Archives
        } |
        ForEach-Object {
            Extract-Archive $_.FullName -UseFolder:$UseFolder
        }
    }
    else {
        Write-Host "Path not found: $ArchivePath"
    }
}