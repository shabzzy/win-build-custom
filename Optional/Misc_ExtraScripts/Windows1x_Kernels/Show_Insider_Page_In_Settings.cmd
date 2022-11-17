@echo off
CLS
color 1f
for /f "tokens=4-5 delims=. " %%i in ('ver') do set "TestWinVer=%%i"
IF %TestWinVer% LSS 10 echo This script only works on Windows 10 Kernels. & GOTO :Finished

TITLE Checking for Admin...
echo.
cd %systemroot%\system32
call :IsAdmin


TITLE Show Insider Programme page in Settings.
cls
echo.
echo Enable/show Insider Programme page in Settings.
Reg add "HKLM\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /v "HideInsiderPage" /t REG_DWORD /d "0" /f >NUL 2>&1
echo.
echo Done. No reboot needed.

:Finished
echo.
pause

exit

=====================================================================================
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & echo. & Echo You must have administrator rights to continue ... & echo.
 Pause & Exit
)
Cls

exit /b
