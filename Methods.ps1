. .\Globals.ps1
function Extract-Archives {
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
            Extract-Archives $_.FullName -Destination:$Destination -UseFolder:$UseFolder
        }
    }
    else {
        Write-Host "Path not found: $ArchivePath"
    }
}

function Flatten-Folder {
    param(
        [string]$RootPath
    )

    Get-ChildItem -LiteralPath $RootPath -File -Recurse |
    Where-Object {
        $_.DirectoryName -ne $RootPath
    } |
    ForEach-Object {
        Move-Item -LiteralPath $_.FullName -Destination $RootPath
    }

    Get-ChildItem -LiteralPath $RootPath -Directory | 
    ForEach-Object {
        Remove-Item -LiteralPath $_.FullName
    }
}

function Get-FilesByFormat {
    param(
        [string]$Path,
        [string[]]$Formats
    )

    Get-ChildItem $Path -File | Where-Object {
        $_.Extension -in $Formats
        }
}

function Remove-FilesByFormat {
    param(
        [string]$Path,
        [string[]]$Formats
    )

    Get-ChildItem -LiteralPath $Path -File | 
    Where-Object {
        $_.Extension -in $Formats
    } | 
    ForEach-Object {
        Remove-Item -LiteralPath $_.FullName
        }
}

function Remove-FilesByMatch {
    param(
        [string]$Path,
        [string]$MatchString
    )
    
    Get-ChildItem -LiteralPath $Path -File |
    Where-Object {
        $_.Name -match $MatchString
    } |
    ForEach-Object {
        Remove-Item -LiteralPath $_.FullName
    }
}

function Test-FolderContains {
    param(
        [string]$Path,
        [string[]]$Patterns
    )

    $FolderName = Split-Path $Path -Leaf
    $PatternText = $Patterns -join "|"

    foreach ($File in (Get-ChildItem -LiteralPath $Path -File)) {
        if ($File.Name -match $PatternText) {
            # Write-Host "$FolderName TRUE"
            return
        }
    }

    Write-Host "$FolderName FALSE"
}

