# Get-PC-Diagnostic.ps1
# ---------------------------
# 這是一個 PC 自動化診斷工具（PC Diagnostic Tool）
# 功能：
# 1. 自動建立 Log 資料夾
# 2. 自動收集 CPU / Memory / Disk 資訊
# 3. 自動進行網路 Ping Test
# 4. 自動檢查系統內常見程式是否存在（notepad / calc）
# 5. 全部輸出成 Log 檔案
# ---------------------------

# 自動使用腳本所在路徑
$logPath = Join-Path $PSScriptRoot "Logs"

# 如果 Logs 資料夾不存在，就建立
if (!(Test-Path $logPath)) {
    New-Item -ItemType Directory -Path $logPath | Out-Null
}

# Log 檔名稱：diag_日期時間.txt
$log = "$logPath\diag_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# 寫入 Log 開頭標題
"=== PC Diagnostic Log ===" | Out-File $log
"Time: $(Get-Date)" | Out-File $log -Append


# ---------------------------
# CPU 資訊
# ---------------------------
"--- CPU Info ---" | Out-File $log -Append

# Get-WmiObject Win32_Processor 用來讀取 CPU 型號與核心數
# Select Name,NumberOfCores -> 抽取想看的欄位
Get-WmiObject Win32_Processor | Select Name,NumberOfCores | Out-File $log -Append


# ---------------------------
# Memory（記憶體）資訊
# ---------------------------
"--- Memory Info ---" | Out-File $log -Append

# Win32_PhysicalMemory 可讀取每條 RAM 的容量（以 Bytes 顯示）
Get-WmiObject Win32_PhysicalMemory | Select Capacity | Out-File $log -Append


# ---------------------------
# Disk（硬碟）資訊
# ---------------------------
"--- Disk Info ---" | Out-File $log -Append

# Win32_LogicalDisk 會列出磁碟空間、剩餘空間
Get-WmiObject Win32_LogicalDisk | Select DeviceID,Size,FreeSpace | Out-File $log -Append


# ---------------------------
# Network Ping Test（網路測試）
# ---------------------------
"--- Network Ping Test ---" | Out-File $log -Append

# Test-Connection 用來 Ping 主機看網路是否正常
Test-Connection google.com -Count 2 | Out-File $log -Append


# ---------------------------
# 檢查常見程式是否存在
# ---------------------------
"--- Program Check ---" | Out-File $log -Append

# 要檢查的程式清單
$apps = @("notepad.exe", "calc.exe", "powershell.exe")

foreach ($app in $apps) {
    # Get-Command 檢查程式是否存在系統中
    if (Get-Command $app -ErrorAction SilentlyContinue) {
        "$app : OK" | Out-File $log -Append
    } else {
        "$app : Missing" | Out-File $log -Append
    }
}

# 結尾
"=== Done ===" | Out-File $log -Append

# 執行完後在畫面顯示 Log 路徑
Write-Host "Diagnosis complete! Log saved to $log"
