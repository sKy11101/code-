@echo off
title Performance Stats - CMD Tool
color 0A

echo ====================================
echo      COMPUTER PERFORMANCE STATS
echo ====================================

:: Date & Time
echo.
echo [System Date & Time]
echo %DATE% %TIME%

:: Basic System Info
echo.
echo [Basic System Information]
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Manufacturer" /C:"System Model" /C:"Total Physical Memory"

:: Uptime
echo.
echo [System Uptime]
wmic os get LastBootUpTime | findstr /R "[0-9]"

:: CPU Load
echo.
echo [CPU Load Percentage]
wmic cpu get loadpercentage

:: Memory Usage
echo.
echo [Memory Usage]
for /f "tokens=2 delims==" %%i in ('"wmic OS get FreePhysicalMemory /Value"') do set FreeMem=%%i
for /f "tokens=2 delims==" %%i in ('"wmic OS get TotalVisibleMemorySize /Value"') do set TotalMem=%%i

set /a UsedMem=%TotalMem% - %FreeMem%
set /a MemUsage=100 * %UsedMem% / %TotalMem%

echo Total Memory : %TotalMem% KB
echo Used Memory  : %UsedMem% KB
echo Usage        : %MemUsage%%

:: Top 5 Memory Consuming Processes
echo.
echo [Top 5 Memory Consuming Processes]
echo.
for /f "skip=3 tokens=1,2,5" %%a in ('tasklist /fo table /nh') do (
    echo %%a %%b %%c
)

:: Optional: Pause before closing
echo.
pause
