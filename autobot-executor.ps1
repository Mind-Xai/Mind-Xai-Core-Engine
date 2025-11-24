$VaultPath = "C:\MindX_Data"
$SignalLog = "$VaultPath\Signal_Map_$(get-date -f yyyy-MM-dd).log"
$DecisionLog = "$VaultPath\AutoBot_Decisions_$(get-date -f yyyy-MM-dd).log"
$Timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
if (Test-Path $SignalLog) {
    $RawData = Get-Content $SignalLog
    $WiFiNodes = ($RawData | Select-String "BSSID").Count
    $BtNodes = ($RawData | Select-String "InstanceId").Count
    $TotalNodes = $WiFiNodes + $BtNodes
    if ($TotalNodes -gt 0) {
        $Action = "EXECUTE_HIGH_FREQUENCY_TRADE"
        $LogEntry = "[$Timestamp] DECISION MATRIX GENERATED Node Density: High ($TotalNodes active signals) Command: $Action Status: QUEUED FOR EXECUTION"
        Add-Content -Path $DecisionLog -Value $LogEntry
    }
}
