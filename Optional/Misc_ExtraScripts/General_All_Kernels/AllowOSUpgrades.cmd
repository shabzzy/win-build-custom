@echo off
CLS
color 1f
TITLE Checking for Admin...
echo.
cd %systemroot%\system32
call :IsAdmin

:StartScript
TITLE Allow OS Upgrades again
cls
color 1f
echo.
SET /p "AllowUG=Do you wish to allow OS Upgrades ? {Y/N} "
echo.
IF /I "%AllowUG%" NEQ "Y" echo No changes made. & echo. & GOTO :Done

for /f "tokens=4-5 delims=. " %%i in ('ver') do set "TestWinVer=%%i.%%j"
SET "WinXOnly="
for /f "tokens=6 delims=[]. " %%O in ('ver') do set "OSBuildVer=%%O"

IF "%TestWinVer%"=="10.2" SET "WinXOnly=1"
IF "%TestWinVer%"=="10.1" SET "WinXOnly=1"
IF "%TestWinVer%"=="10.0" SET "WinXOnly=1"

echo Updating registry...

Reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DisableOSUpgrade" /f >NUL 2>&1
Reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgrade" /f >NUL 2>&1
Reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferUpgradePeriod" /f >NUL 2>&1

Reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "AllowOSUpgrade" /f >NUL 2>&1
Reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /v "ReservationsAllowed" f >NUL 2>&1
Reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "OSUpgrade" /f >NUL 2>&1
Reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v "ReservationsAllowed" /f >NUL 2>&1
Reg delete "HKLM\SYSTEM\Setup\UpgradeNotification" /v "UpgradeAvailable" /f >NUL 2>&1

for %%i in (SetupHost Setupprep WindowsUpdateBox Windows10Upgrade Windows10UpgraderApp) do REG delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%i.exe" /f >NUL 2>&1

REM Windows 10
SET "MRPBRVer="
IF DEFINED WinXOnly (
	for /F "tokens=3" %%A IN ('REG QUERY "HKLM\Software\Microsoft\PolicyManager\default\Update\BranchReadinessLevel" /v "Value" 2^>nul') DO SET /a "MRPBRVer=%%A"
	IF NOT DEFINED MRPBRVer for /F "tokens=3" %%A IN ('REG QUERY "HKLM\SOFTWARE" /v "MRP_BR_Version" 2^>nul') DO SET /a "MRPBRVer=%%A"
	Reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableOSUpgrade" /f >NUL 2>&1
	Reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DeferUpgrade" /f >NUL 2>&1
	Reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DeferUpgradePeriod" /f >NUL 2>&1

	REG delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdates" /f >NUL 2>&1
	REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d "0" /f >NUL 2>&1
	REG delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "PauseFeatureUpdatesStartTime" /f >NUL 2>&1

	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "DeferFeatureUpdates" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "DeferQualityUpdates" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\PolicyState" /v "IsDeferrallsActive" /t REG_DWORD /d "0" /f >NUL 2>&1

	Reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedFeatureStatus" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UpdatePolicy\Settings" /v "PausedQualityStatus" /t REG_DWORD /d "0" /f >NUL 2>&1

	IF DEFINED MRPBRVer reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "BranchReadinessLevel" /t REG_DWORD /d "%MRPBRVer%" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "DeferFeatureUpdatesPeriodInDays" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "DeferQualityUpdatesPeriodInDays" /t REG_DWORD /d "0" /f >NUL 2>&1
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "DeferUpgrade" /t REG_DWORD /d "0" /f >NUL 2>&1
	REG delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "HideMCTLink" /f >NUL 2>&1

)

:DoneScript
echo.
echo Completed - script ended, reboot required.

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
