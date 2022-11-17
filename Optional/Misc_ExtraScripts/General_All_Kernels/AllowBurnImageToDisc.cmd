@echo off
CLS
color 1f
TITLE Checking for Admin...
echo.
cd %systemroot%\system32
call :IsAdmin

:StartScript
TITLE Allow 'Burn xyz image to disc' feature...
cls
color 1f
echo.

echo Updating registry...

REM ADD burn disc image--context menu
reg add "HKCR\Windows.IsoFile\shell\burn" /v "MUIVerb" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\isoburn.exe,-351" /f >nul 2>&1
reg add "HKCR\Windows.IsoFile\shell\burn\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\isoburn.exe \"%%1\"" /f >nul 2>&1

REM Enable cd/dvd burning features.
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoCDBurning" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoCDBurning" /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f >nul 2>&1

:DoneScript
echo.
echo Completed - script ended, reboot IS required.

:Done
echo.
Pause
exit

=====================================================================================
:IsAdmin
Reg query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & echo. & Echo You must have administrator rights to continue ... & echo.
 Pause & Exit
)
Cls

exit /b
