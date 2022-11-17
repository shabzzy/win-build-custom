@echo off
TITLE Server Lock/Log-In Screen Policy revert script.
COLOR 1F

cd "%systemroot%\system32"
call :IsAdmin

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "LockScreenImage" /f >NUL 2>&1
echo Reg Policy reverted. Reboot may not be required.
echo.
pause


REM To re-enable the policy remove the :: from the lines below. You can change the location for the image if required.
:: Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "LockScreenImage" /t REG_SZ /d "%SystemDrive%\Windows\Web\Screen\img100.jpg" /f >NUL 2>&1
:: echo Reg Policy created.
:: echo.
:: pause

exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 CLS
 echo.
 Echo You must have administrator rights to continue, close and run as Administrator.
 echo.
 Pause
 Exit
)
Cls
goto:eof
