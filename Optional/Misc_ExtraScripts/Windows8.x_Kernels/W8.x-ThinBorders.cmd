@echo off

TITLE Windows 8.x Thinner Border Tweak
COLOR 1F
echo.

SET "8Kernel="
for /f "tokens=4-5 delims=. " %%i in ('ver') do set "TestWinVer=%%i.%%j"
IF "%TestWinVer%"=="6.3" SET "8Kernel=1"
IF "%TestWinVer%"=="6.2" SET "8Kernel=1"
IF NOT DEFINED 8Kernel GOTO :Finished

cd %systemroot%\system32
call :IsAdmin
CLS
TITLE Windows 8.x Thinner Border Tweak
COLOR 1F

REM Thinner boarders in Windows 8.x
Reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "0" /f >NUL 2>&1
Reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f >NUL 2>&1

Reg add "HKLM\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /t REG_SZ /d "0" /f >NUL 2>&1
Reg add "HKLM\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /t REG_SZ /d "0" /f >NUL 2>&1

echo.
echo Done. Log Out Required.

:Finished
IF NOT DEFINED 8Kernel echo Incorrect OS Kernel, Only for 6.2/6.3 Windows 8.x based.
TIMEOUT /T 5 >NUL 2>&1
exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls
 echo.
 Echo You must have administrator rights to continue...
 echo.
 Pause
 Exit
)
