@echo off
CLS
color 1f
TITLE Checking for Admin...
echo.
cd %systemroot%\system32
call :IsAdmin

:StartScript
TITLE Allow Remote Assistance/Connections again
cls
color 1f
echo.
SET /p "AllowUG=Do you wish to allow Remote Assistance/Connections ? {Y/N} "
echo.
IF /I "%AllowUG%" NEQ "Y" echo No changes made. & echo. & GOTO :Done


echo Updating registry etc...

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d "1" /f >NUL 2>&1 && echo Remote Assistance Enabled. || echo Failed to set Remote Assistance.
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v "fDenyTSConnections" /t REG_DWORD /d "0" /f >NUL 2>&1 && echo Allow Connections Enabled. || echo Failed to set Allow Connections.
Reg add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v "UserAuthentication" /t REG_DWORD /d "1" /f >NUL 2>&1 && echo User Authentication Enabled. || echo Failed to set User Authentication.
netsh advfirewall firewall set rule group="Remote Assistance" new enable=yes >NUL 2>&1 && echo Remote Assistance Firewall Rule Enabled. || echo Failed to set Remote Assistance Firewall Rule.

:DoneScript
echo.
echo Completed - script ended, No reboot required.

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
