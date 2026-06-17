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
        [string]$ArchivePath
    )

    $Out
}