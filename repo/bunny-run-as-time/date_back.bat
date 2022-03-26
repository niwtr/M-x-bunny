@echo off
if not "%1"=="am_admin" (C:/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe start -verb runas '%0' am_admin & exit /b)
date 2021/12/22
