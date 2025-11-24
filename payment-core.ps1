param ([string]$TransactionID, [string]$Amount, [string]$Gateway = "MindX_Secure_Gateway")
$LogFile = "C:\MindX_Data\Payment_Logs_$(get-date -f yyyy-MM-dd).log"
$Timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ss.fffZ"
function Test-EncryptedSignal {
    param ($ID)
    if (-not (Test-Path "C:\MindX_Data")) { New-Item -ItemType Directory -Path "C:\MindX_Data" -Force | Out-Null }
    $Hash = Get-FileHash -InputStream ([IO.MemoryStream]::new([Text.Encoding]::UTF8.GetBytes($ID))) -Algorithm SHA256
    return $Hash.Hash
}
try {
    Write-Output "[$Timestamp] INFO: Starting verification for ID: $TransactionID" | Out-File -Append $LogFile
    $SecureHash = Test-EncryptedSignal -ID $TransactionID
    if ($SecureHash) {
        Write-Output "[$Timestamp] SUCCESS: Signal Verified. Hash: $SecureHash" | Out-File -Append $LogFile
        return $true
    }
}
catch {
    Write-Output "[$Timestamp] ERROR: Verification Failed. $_.Exception.Message" | Out-File -Append $LogFile
    return $false
}
