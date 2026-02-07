# pack-assets.ps1
# Creates valentine-assets.zip containing the ./assets directory (recursively).
# Run this from your project root (the folder that contains index.html and assets/).

$Out = "valentine-assets.zip"
$Src = "assets"

if (-not (Test-Path $Src -PathType Container)) {
    Write-Error "Error: '$Src' directory not found in $(Get-Location)"
    exit 1
}

if (Test-Path $Out) {
    Write-Host "Removing existing $Out"
    Remove-Item $Out -Force
}

Write-Host "Creating $Out from $Src ..."
# Compress-Archive will include the folder itself; to keep same behavior as zip -r, include the folder
Compress-Archive -Path "$Src\*" -DestinationPath $Out

Get-ChildItem -Path $Out | Select-Object Name, Length
Write-Host "Done."