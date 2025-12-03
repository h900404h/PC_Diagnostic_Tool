# PC Diagnostic Tool & Environment Setup (PowerShell)

This repository contains two simple PowerShell tools:

## 1. Get-PC-Diagnostic.ps1
A basic PC diagnostic script that collects:
- CPU information
- Memory information
- Disk usage
- Network ping test
- Program existence check

Outputs all results into a timestamped log under the `Logs/` folder.

## 2. Setup-Environment.ps1
A one-click script that prepares a working environment.  
It automatically creates:

- Logs/
- Tools/
- Temp/
- Config/

It also creates a `config.ini` and sets a user environment variable:

```
TEST_ENV = <script_location>
```

Both scripts are easy to run and useful for simple test automation tasks.
