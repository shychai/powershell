$Paths = @{
    Downloads = Join-Path $HOME "Downloads"
    Desktop   = Join-Path $HOME "Desktop"
    Studio    = Join-Path $Desktop "studio"
    Data      = Join-Path $Studio "data"
    Dev       = Join-Path $Studio "dev"
    Scripts   = Join-Path $Studio "scripts"
    PowerShell = Join-Path $Scripts "powershell"
}

$Formats = @{
    Archives = @(".zip",".7z",".rar")
}

$Tools = @{
    SevZip = "C:\Program Files\7-Zip\7z.exe"
}

