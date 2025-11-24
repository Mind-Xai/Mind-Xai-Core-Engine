# MINDX AI - AUTO PILOT SYSTEM V1.0
param(
    [string]$Action
)

function Show-Header {
    Clear-Host
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "      MINDX AI | ROBOTIC COMMAND        " -ForegroundColor White
    Write-Host "========================================" -ForegroundColor Cyan
}

function Sync-Cloud {
    Write-Host "
[ROBOT] INITIATING CLOUD SYNC..." -ForegroundColor Yellow
    Set-Location "C:\MindX\MindX-Core"
    git add .
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    git commit -m "Auto-Update: $timestamp"
    git push origin main
    if ($?) {
        Write-Host "[SUCCESS] SYSTEM UPDATED." -ForegroundColor Green
    } else {
        Write-Host "[ERROR] SYNC FAILED." -ForegroundColor Red
    }
    Pause
}

while ($true) {
    Show-Header
    Write-Host " 1. [EDIT]   Open Codebase" -ForegroundColor Yellow
    Write-Host " 2. [SYNC]   Auto-Push to Cloud" -ForegroundColor Magenta
    Write-Host " 3. [VIEW]   Launch Live Satellite" -ForegroundColor Green
    Write-Host " 4. [EXIT]   Shutdown" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Cyan
    
    $choice = Read-Host " COMMAND >"

    switch ($choice) {
        '1' { notepad "C:\MindX\MindX-Core\index.html" }
        '2' { Sync-Cloud }
        '3' { Start-Process "https://mind-xai.github.io/Mind-Xai-Core-Engine/" }
        '4' { exit }
    }
}
