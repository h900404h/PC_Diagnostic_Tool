# Setup-Environment.ps1
# ---------------------------------------------------
# 一鍵建置測試環境的 Script
# 功能：
# 1. 在腳本所在位置底下建立基本資料夾結構
#    - Logs
#    - Tools
#    - Temp
#    - Config
# 2. 設定環境變數 TEST_ENV，指向目前環境根目錄
# 3. 建立一個簡單的設定檔 config.ini
# 4. 在畫面上顯示建置結果
# ---------------------------------------------------

# 取得目前腳本所在的資料夾路徑
$basePath = $PSScriptRoot

# 要建立的子資料夾清單
$folders = @(
    (Join-Path $basePath "Logs"),
    (Join-Path $basePath "Tools"),
    (Join-Path $basePath "Temp"),
    (Join-Path $basePath "Config")
)

Write-Host "=== Setup Environment Start ==="
Write-Host "Base Path: $basePath"
Write-Host ""

# 1. 建立資料夾
foreach ($folder in $folders) {
    if (!(Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
        Write-Host "Created folder: $folder"
    } else {
        Write-Host "Folder already exists: $folder"
    }
}

Write-Host ""

# 2. 設定環境變數 TEST_ENV（User 範圍，比較安全，不需要管理員）
#    之後在 PowerShell / CMD 中都可以使用 %TEST_ENV% 或 $env:TEST_ENV
[System.Environment]::SetEnvironmentVariable("TEST_ENV", $basePath, "User")
Write-Host "Environment variable 'TEST_ENV' set to: $basePath"
Write-Host ""

# 3. 建立簡單設定檔，放在 Config 資料夾中
$configFile = Join-Path $basePath "Config\config.ini"

if (!(Test-Path $configFile)) {
    @"
[Environment]
RootPath=$basePath
LogsPath=$(Join-Path $basePath "Logs")
ToolsPath=$(Join-Path $basePath "Tools")
TempPath=$(Join-Path $basePath "Temp")

[Info]
CreatedAt=$(Get-Date)
CreatedBy=Setup-Environment.ps1
"@ | Out-File $configFile -Encoding UTF8

    Write-Host "Config file created: $configFile"
} else {
    Write-Host "Config file already exists: $configFile"
}

Write-Host ""
Write-Host "=== Setup Environment Completed ==="
