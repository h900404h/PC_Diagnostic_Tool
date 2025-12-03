# PC 診斷工具 & 環境初始化工具（PowerShell）

這個資料庫包含兩個簡單實用的 PowerShell 工具：

---

## 1. Get-PC-Diagnostic.ps1  
一個基本的 PC 診斷腳本，用來收集系統狀態，包括：

- CPU 資訊  
- 記憶體使用狀況  
- 磁碟空間  
- 網路 Ping 測試  
- 常用程式是否存在  

執行後會將結果輸出到 `Logs/` 資料夾下，以時間戳記命名的 log 檔。

---

## 2. Setup-Environment.ps1  
一鍵建立工作環境的腳本，會自動建立：

- Logs/  
- Tools/  
- Temp/  
- Config/

並會建立 `config.ini`，同時設定一個使用者環境變數：

