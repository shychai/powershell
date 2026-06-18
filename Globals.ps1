$Paths = @{
    Downloads = Join-Path $HOME "Downloads"
    Desktop   = Join-Path $HOME "Desktop"
}

$Paths.Studio = Join-Path $Paths.Desktop "studio"
$Paths.Data = Join-Path $Paths.Studio "data"
$Paths.Dev = Join-Path $Paths.Studio "dev"
$Paths.Scripts = Join-Path $Paths.Studio "scripts"
$Paths.PowerShell = Join-Path $Paths.Scripts "powershell"

$Formats = @{
    Archives = @(".zip",".7z",".rar")
}

$Tools = @{
    SevZip = "C:\Program Files\7-Zip\7z.exe"
}

