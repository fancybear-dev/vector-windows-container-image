param(
    [Parameter(Mandatory=$true)]
    [string]$VectorVersion
)

Write-Host "VECTOR_VERSION: $VectorVersion"
$url = "https://github.com/vectordotdev/vector/releases/download/v${VectorVersion}/vector-${VectorVersion}-x86_64-pc-windows-msvc.zip"
Write-Host "Download URL: $url"
Invoke-WebRequest -UseBasicParsing -Uri $url -OutFile "vector.zip"

$installDir = "C:/Program Files/Vector"
if (-not (Test-Path -Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
}

Expand-Archive -Path "vector.zip" -DestinationPath $installDir
Remove-Item "vector.zip" -Force