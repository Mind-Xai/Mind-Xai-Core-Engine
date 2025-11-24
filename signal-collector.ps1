$LogPath = "C:\MindX_Data\Signal_Map_$(get-date -f yyyy-MM-dd).log"
$Timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
function Get-RadioSignals {
    $Networks = netsh wlan show networks mode=bssid
    $Devices = Get-PnpDevice -Class Bluetooth -Status OK | Select-Object -First 5
    return @{ WiFi = $Networks; Bluetooth = $Devices }
}
try {
    if (-not (Test-Path "C:\MindX_Data")) { New-Item -ItemType Directory -Path "C:\MindX_Data" -Force | Out-Null }
    $Data = Get-RadioSignals
    $LogEntry = "[$Timestamp] SIGNAL SWEEP COMPLETE [RADIO FREQUENCY / WIFI NODES DETECTED] $($Data.WiFi | Out-String) [BLUETOOTH / DEVICE NODES ACTIVE] $($Data.Bluetooth | Format-Table -AutoSize | Out-String)"
    Add-Content -Path $LogPath -Value $LogEntry
}
catch {
    Write-Host "SCAN ERROR: $_.Exception.Message" -ForegroundColor Red
}
