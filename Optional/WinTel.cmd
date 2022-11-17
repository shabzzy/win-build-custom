@echo off
COLOR 1F
SET "ErrCode=0"
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: :: 'WinTel.cmd' -> 'Windows 10/11' > 'Windows 8.x' > 'Windows 7' > 'Windows Vista' | Sept 2022 ::
:: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Servers may work with the WinTel.cmd contents, but this is untested and may cause unwanted effects or failure so be warned.

:: Feel free to add your own telemetry tweaks etc, but remember *NO* support will be given for your own changes or errors!

:: Some new parts added for Windows 10 only, one part is bypassed as this is for extra removals and it is up to you to 
:: decide to use or not.

:: To run standalone you will need to run this script as administrator.

REM TurnOffClipboardHistoryService=Yes -- Turn off history service (possible malware injection could happen at some point via a 3rd party)  [RS5+]
REM TurnOffClipboardHistoryService=    -- Leave alone.
SET "TurnOffClipboardHistoryService="

REM Set as Yes to remove this Context Menu entry.
SET "RemoveEditWithPhotos="


SET "OSARCH=x86"
SET "OSBits="
FOR /f "tokens=2 delims==" %%a in ('wmic os get osarchitecture /value 2^>nul') do set "OSBits=%%a"

ECHO "%OSBits%" | FINDSTR "64" >NUL 2>&1 && ( SET "OSARCH=x64" )
ECHO "%OSBits%" | FINDSTR "32" >NUL 2>&1 && ( SET "OSARCH=x86" )
IF /I "%OSARCH%"=="x64" GOTO :DoneArchChk

IF DEFINED OSBits IF /I "%OSBits%"=="64-Bit" SET "OSARCH=x64"
IF DEFINED OSBits IF /I "%OSBits%"=="32-Bit" SET "OSARCH=x86"
IF /I "%OSARCH%"=="x64" GOTO :DoneArchChk

REM Recheck if x86/x64 to make sure it's correct.
ECHO "%PROCESSOR_ARCHITECTURE%" | FINDSTR "86" >NUL 2>&1 && ( SET "OSARCH=x86" )
ECHO "%PROCESSOR_ARCHITECTURE%" | FINDSTR "64" >NUL 2>&1 && ( SET "OSARCH=x64" )
IF /I "%OSARCH%"=="x64" GOTO :DoneArchChk

SET "OSARCH=x64"
IF /I "%PROCESSOR_ARCHITECTURE%"=="x86" IF "%PROCESSOR_ARCHITEW6432%"=="" SET "OSARCH=x86"
IF /I "%OSARCH%"=="x64" GOTO :DoneArchChk

SET "OSARCH=x86"
IF EXIST "%systemdrive%\Program Files (x86)\" SET "OSARCH=x64"
IF NOT DEFINED OSARCH SET "OSARCH=x86"

:DoneArchChk
for /f "tokens=4-5 delims=. " %%V in ('ver') do set "TestWinVer=%%V.%%W"
SET "WinV="
IF "%TestWinVer%"=="10.2" SET "WinV=10"
IF "%TestWinVer%"=="10.1" SET "WinV=10"
IF "%TestWinVer%"=="10.0" SET "WinV=10"
IF "%TestWinVer%"=="6.3" SET "WinV=8_1"
IF "%TestWinVer%"=="6.2" SET "WinV=8"
IF "%TestWinVer%"=="6.1" SET "WinV=7"
IF "%TestWinVer%"=="6.0" SET "WinV=Vista"

:: Route known Telemetry IP's to nothing.
:ROUTEIPS
2>nul ROUTE -p ADD 23.99.10.11 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.102.21.4 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.87 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.95 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.96 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.97 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.110 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.121 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.161 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.212.108.177 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.214.157.183 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.214.162.198 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 23.218.212.69 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 37.252.163.4 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.163.18 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.163.155 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.162.53 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.162.89 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.162.98 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.162.201 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.162.244 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.170.142 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.170.182 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.170.123 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.170.140 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 37.252.170.141 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 64.4.6.100 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 64.4.11.42 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 64.4.54.22 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 64.4.54.32 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 64.4.54.153 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 64.4.54.254 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 65.39.117.230 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.7 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.9 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.11 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.91 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.93 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.92 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.100.94 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.108.11 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.108.29 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.52.108.153 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.54.226.187 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.29.238 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.39.10 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.44.85 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.44.109 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.108.23 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.128.81 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.138.112 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.138.114 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.138.126 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.138.186 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.163.221 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.163.222 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.194.241 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.252.43 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.252.63 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.252.71 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.252.92 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.252.93 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 65.55.252.190 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 68.67.152.94 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.153.87 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.153.37 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.152.174 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.152.173 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.152.110 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.152.120 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 68.67.152.172 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 82.199.80.143 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 93.184.215.200 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 93.184.221.200 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 94.245.121.179 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 94.245.121.176 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 94.245.121.177 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 94.245.121.178 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 96.6.122.184 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.218 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.216 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.144 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.67 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.73 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.169 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.224 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 96.6.122.74 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 98.124.243.41 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 111.221.29.177 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 111.221.29.253 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 111.221.29.254 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 131.107.255.255 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 131.253.40.37 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 131.253.40.44 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 134.170.30.202 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.58.190 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.115.60 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.115.62 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.185.70 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.165.248 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.165.249 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 134.170.165.253 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 137.116.81.24 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 137.117.235.16 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 157.55.129.21 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.55.133.204 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.17.248 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.67.218 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.91.77 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.96.58 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.96.123 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.100.83 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.56.121.89 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 157.58.249.57 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 168.61.24.141 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 168.62.187.13 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 168.63.108.233 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 173.252.88.160 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 191.232.80.58 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 191.232.80.60 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 191.232.80.62 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 191.232.139.253 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 191.232.139.254 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 191.232.140.76 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 191.237.208.126 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 192.229.233.249 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 207.46.101.29 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 207.46.114.58 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 207.46.194.10 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 207.46.223.94 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 207.68.166.254 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 212.30.134.204 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 212.30.134.205 MASK 255.255.255.255 0.0.0.0 >nul

2>nul ROUTE -p ADD 216.38.172.128 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 216.58.198.230 MASK 255.255.255.255 0.0.0.0 >nul

:: The following block begining 204.79.197.xxx can stop MSN.com and Outlook.com from working!
:: If you use MS online products/Apps leave the GOTO :BypassMSNRouteBlock as it is, if you 
:: wish to block those then place a REM or :: before the GOTO :BypassMSNRoutBlock command.

GOTO :BypassMSNRouteBlock

REM WARNING: Enabling this block can affect some Microsoft Apps and websites.
2>nul ROUTE -p ADD 204.79.197.197 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.200 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.201 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.203 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.204 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.206 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.208 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.209 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.210 MASK 255.255.255.255 0.0.0.0 >nul
2>nul ROUTE -p ADD 204.79.197.211 MASK 255.255.255.255 0.0.0.0 >nul


:BypassMSNRouteBlock
:: Query scheduled known 'telemetry' tasks and disable if present.  You can enable them again if required just use /Enable instead of /Disable if you wish.

REM Customer Experience
2>nul SCHTASKS /query | findstr /B /I "KernelCeipTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "UsbCeip" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Consolidator" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Uploader" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Uploader" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "BthSQM" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /DISABLE >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "TelTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\TelTask" /DISABLE >NUL 2>&1

REM Windows Tasks
2>nul SCHTASKS /query | findstr /B /I "GatherNetworkInfo" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Enable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "AnalyzeSystem" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Proxy" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "SmartScreenSpecific" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Sqm-Tasks" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "CreateObjectTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "QueueReporting" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Pre-staged app cleanup" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\AppxDeploymentClient\Pre-staged app cleanup" /DISABLE >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Scheduled" >nul 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable >nul 2>&1
2>nul SCHTASKS /query | findstr /B /I "WinSAT" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable >NUL 2>&1

REM ** Below are tasks that do some system checking, remove the :: before to disable these **
REM ** remarked out if you do not need these tasks running. They can prevent network diagnostics/troubleshooting if disabled. **
:: 2>nul SCHTASKS /query | findstr /B /I "Microsoft-Windows-DiskDiagnosticDataCollector" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >NUL 2>&1
:: 2>nul SCHTASKS /query | findstr /B /I "GatherNetworkInfo" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable >NUL 2>&1
:: 2>nul SCHTASKS /query | findstr /B /I "File History (maintenance mode)" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable >NUL 2>&1
:: 2>nul SCHTASKS /query | findstr /B /I "Diagnostics" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable >NUL 2>&1

REM SearchIndexer
2>nul SCHTASKS /query | findstr /B /I "ResPriStaticDbSync" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Sysmain\ResPriStaticDbSync" /DISABLE >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "WsSwapAssessmentTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /DISABLE >NUL 2>&1

REM Family Safety
2>nul SCHTASKS /query | findstr /B /I "FamilySafetyMonitor" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyMonitor" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "FamilySafetyRefresh" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyRefresh" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "FamilySafetyUpload" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Shell\FamilySafetyUpload" /Disable >NUL 2>&1

REM Application Experience  -- Microsoft Compatibility Appraiser is a known task that can re-enable itself even if deleted from Task Scheduler!!
2>nul SCHTASKS /query | findstr /B /I "AitAgent" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\AitAgent" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "ProgramDataUpdater" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "StartupAppTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Microsoft Compatibility Appraiser" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >NUL 2>&1

REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" /v "HaveUploadedForTarget" /t REG_DWORD /d "1" /f >NUL 2>&1
REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AIT" /v "AITEnable" /t REG_DWORD /d "0" /f >NUL 2>&1
REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v "DontRetryOnError" /t REG_DWORD /d "1" /f >NUL 2>&1
REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v "IsCensusDisabled" /t REG_DWORD /d "1" /f >NUL 2>&1
REG add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v "TaskEnableRun" /t REG_DWORD /d "0" /f >NUL 2>&1
REG delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\TelemetryController" /f >NUL 2>&1

REM Office
2>nul SCHTASKS /query | findstr /B /I "OfficeTelemetryAgentLogOn" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentLogOn" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "OfficeTelemetryAgentFallBack" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetryAgentFallBack" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Office 15 Subscription Heartbeat" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\Office 15 Subscription Heartbeat" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "Office 16 Subscription Heartbeat" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\Office 16 Subscription Heartbeat" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "OfficeTelemetryAgentLogOn2016" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetry\OfficeTelemetryAgentLogOn2016" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "AgentFallBack2016" >NUL 2>&1 && SCHTASKS /change /TN "Microsoft\Office\OfficeTelemetry\AgentFallBack2016" /Disable >NUL 2>&1

REM Next ready for Office 2019.
2>nul SCHTASKS /query | findstr /B /I "Office 19 Subscription Heartbeat" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\Office 19 Subscription Heartbeat" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "OfficeTelemetryAgentLogOn2019" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Office\OfficeTelemetry\OfficeTelemetryAgentLogOn2019" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "AgentFallBack2019" >NUL 2>&1 && SCHTASKS /change /TN "Microsoft\Office\OfficeTelemetry\AgentFallBack2019" /Disable >NUL 2>&1

REM If you disable this Msctf task you will probably not be able to type in Edge/Apps/Settings. Leave Enabled.
2>nul SCHTASKS /query | findstr /B /I "MsCtfMonitor" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\TextServicesFramework\MsCtfMonitor" /Enable >NUL 2>&1

REM Media Center Telemetry remove the GOTO line below to disable these tasks if required.
GOTO :DoneMediaCenterTasks
2>nul SCHTASKS /query | findstr /B /I "ConfigureInternetTimeService" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\ConfigureInternetTimeService" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "DispatchRecoveryTasks" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\DispatchRecoveryTasks" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "ehDRMInit" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\ehDRMInit" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "InstallPlayReady" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\InstallPlayReady" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "mcupdate" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\mcupdate" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "MediaCenterRecoveryTask" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\MediaCenterRecoveryTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "ObjectStoreRecoveryTask" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\ObjectStoreRecoveryTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "OCURActivate" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\OCURActivate" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "OCURDiscovery" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\OCURDiscovery" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "PBDADiscovery" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\PBDADiscovery" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "PBDADiscoveryW1" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\PBDADiscoveryW1" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "PBDADiscoveryW2" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\PBDADiscoveryW2" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "PvrRecoveryTask" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\PvrRecoveryTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "PvrScheduleTask" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\PvrScheduleTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "ActivateWindowsSearch" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\ActivateWindowsSearch" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "RegisterSearch" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\RegisterSearch" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "ReindexSearchRoot" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\ReindexSearchRoot" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "SqlLiteRecoveryTask" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\SqlLiteRecoveryTask" /Disable >NUL 2>&1
2>nul SCHTASKS /query | findstr /B /I "UpdateRecordPath" >NUL 2>&1 && schtasks /Change /TN "Microsoft\Windows\Media Center\UpdateRecordPath" /Disable >NUL 2>&1

:DoneMediaCenterTasks
:: Telemetry query for running services to delete/disable
FOR /F "tokens=3 delims=: " %%S in ('SC query "DiagTrack" ^| findstr "        STATE" 2^>nul') do (
 IF /I "%%S" EQU "RUNNING" ( SC stop DiagTrack >NUL 2>&1 & SC delete DiagTrack >NUL 2>&1 & GOTO :NEXT )
 IF /I "%%S" EQU "STOPPED" ( SC delete DiagTrack >NUL 2>&1 & GOTO :NEXT )
)

:NEXT
FOR /F "tokens=3 delims=: " %%S in ('SC query "dmwappushservice" ^| findstr "        STATE" 2^>nul') do (
 IF /I "%%S" EQU "RUNNING" ( SC stop dmwappushservice >NUL 2>&1 & SC delete dmwappushservice >NUL 2>&1 & GOTO :NEXT2 )
 IF /I "%%S" EQU "STOPPED" ( SC delete dmwappushservice >NUL 2>&1 & GOTO :NEXT2 )
)

:NEXT2
REM For RS4 do not delete this service or any with same CDPUserSvc_xxxxx name or TaskView fails to work!
FOR /F "tokens=3 delims=: " %%S in ('SC query "CDPUserSvc_*" ^| findstr "        STATE" 2^>nul') do (
 IF /I "%%S" EQU "RUNNING" ( SC stop CDPUserSvc_* >NUL 2>&1 & GOTO :NEXT3 )
)

:NEXT3
FOR /F "tokens=3 delims=: " %%S in ('SC query "diagnosticshub.standardcollector.service" ^| findstr "        STATE" 2^>nul') do (
 IF /I "%%S" EQU "RUNNING" ( SC stop diagnosticshub.standardcollector.service >NUL 2>&1 & SC delete diagnosticshub.standardcollector.service >NUL 2>&1 & GOTO :ETLLOGGING )
 IF /I "%%S" EQU "STOPPED" ( SC delete diagnosticshub.standardcollector.service >NUL 2>&1 & GOTO :ETLLOGGING )
)

:: Disable if present: Diagnosis folder and .etl file locations for telemetry logging
:ETLLOGGING
IF NOT EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" GOTO :CHECK2
IF EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\" ( 2>nul TAKEOWN /F "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis" >nul & 2>nul ICACLS "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis" /reset /T /Q >NUL 2>&1 ) >NUL 2>&1
IF EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" ( TAKEOWN /F "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" >NUL 2>&1 & ICACLS "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" /reset /T /Q >NUL 2>&1 & DEL /F /Q "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" >NUL 2>&1 ) >NUL 2>&1

:CHECK2
IF NOT EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl" GOTO :CHECK3
IF EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl" ( TAKEOWN /F "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl" >NUL 2>&1 & ICACLS "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl" /reset /T /Q >NUL 2>&1 & DEL /F /Q "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\ETLLogs\ShutdownLogger\AutoLogger-Diagtrack-Listener.etl" >NUL 2>&1 ) >NUL 2>&1

:CHECK3
IF NOT EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\" GOTO :ExtraBits0
IF EXIST "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis\" ICACLS "%SYSTEMDRIVE%\ProgramData\Microsoft\Diagnosis" /remove:g SYSTEM /inheritance:r /deny SYSTEM:(OI)(CI)F >NUL 2>&1

:ExtraBits0
:: Remove 'End Of Support' messages for Win7 via KB4493132...
for /f "tokens=6 delims=[]. " %%# in ('ver') do set "winbuild=%%#"
IF NOT DEFINED WinBuild goto :Continue0
if %winbuild% GTR 7601 goto :Continue0

%REGEXE% add "HKCU\Software\Microsoft\Windows\CurrentVersion\SipNotify" /f /v "DontRemindMe" /t REG_DWORD /d "1" >NUL 2>&1
%REGEXE% add "HKCU\Software\Microsoft\Windows\CurrentVersion\SipNotify" /f /v "DateModified" /t REG_QWORD /d "0x0" >NUL 2>&1
%REGEXE% add "HKCU\Software\Microsoft\Windows\CurrentVersion\SipNotify" /f /v "LastShown" /t REG_QWORD /d "0x0" >NUL 2>&1
schtasks /Change /DISABLE /TN "Microsoft\Windows\End Of Support\Notify1" >NUL 2>&1
schtasks /Change /DISABLE /TN "Microsoft\Windows\End Of Support\Notify2" >NUL 2>&1
schtasks /Delete /F /TN "Microsoft\Windows\End Of Support\Notify1" >NUL 2>&1
schtasks /Delete /F /TN "Microsoft\Windows\End Of Support\Notify2" >NUL 2>&1

set "hosts=%windir%\system32\drivers\etc\hosts"
 FindStr /i "RE2JgkA" %hosts% 1>nul 2>nul || (
 attrib -r "%hosts%" >NUL 2>&1
 echo 127.0.0.1 query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE2JgkA>>"%hosts%"
 attrib +r "%hosts%" >NUL 2>&1
 attrib -a "%hosts%" >NUL 2>&1
)

:Continue0
:: Turn off Windows Customer Experience Improvement Program (CEIP)
reg add "HKLM\SOFTWARE\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f >nul 2>&1

:: Turn off Application Telemetry
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f >nul 2>&1

:: Retail Demo Service. Mainly for shops with a 'demo' display system in place.
sc config RetailDemo start= disabled >NUL 2>&1

REM Smartscreen disable.
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d "0" /f >nul 2>&1

REM Current User - Prevent certain 'turned off' messages.
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Appx\32095775-5197-4f30-8cd8-990a7f2be3b7" /v "Value" /t REG_SZ /d "<FilePublisherRule Id=\"32095775-5197-4f30-8cd8-990a7f2be3b7\" Name=\"Microsoft.Windows.ContentDeliveryManager, from Microsoft Corporation\" Description=\"\" UserOrGroupSid=\"S-1-1-0\" Action=\"Deny\"><Conditions><FilePublisherCondition PublisherName=\"CN=Microsoft Windows, O=Microsoft Corporation, L=Redmond, S=Washington, C=US\" ProductName=\"Microsoft.Windows.ContentDeliveryManager\" BinaryName=\"*\"><BinaryVersionRange LowSection=\"*\" HighSection=\"*\"/></FilePublisherCondition></Conditions></FilePublisherRule>" /f >NUL 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\SystemCertificates" /f >NUL 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Dll" /f >NUL 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Exe" /f >NUL 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Msi" /f >NUL 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Script" /f >NUL 2>&1
Reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}User" /f >NUL 2>&1

REM Local Machine - Prevent certain 'turned off' messages.
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Appx\32095775-5197-4f30-8cd8-990a7f2be3b7" /v "Value" /t REG_SZ /d "<FilePublisherRule Id=\"32095775-5197-4f30-8cd8-990a7f2be3b7\" Name=\"Microsoft.Windows.ContentDeliveryManager, from Microsoft Corporation\" Description=\"\" UserOrGroupSid=\"S-1-1-0\" Action=\"Deny\"><Conditions><FilePublisherCondition PublisherName=\"CN=Microsoft Windows, O=Microsoft Corporation, L=Redmond, S=Washington, C=US\" ProductName=\"Microsoft.Windows.ContentDeliveryManager\" BinaryName=\"*\"><BinaryVersionRange LowSection=\"*\" HighSection=\"*\"/></FilePublisherCondition></Conditions></FilePublisherRule>" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\SystemCertificates" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Dll" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Exe" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Msi" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}Machine\Software\Policies\Microsoft\Windows\SrpV2\Script" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy Objects\{250FEABB-7D5C-4556-8753-B62A66E5858B}User" /f >NUL 2>&1

REM Some 'extra' services to disable if you wish...
REM AppVClient,NetTcpPortSharing,UevAgentService,WbioSrvc,OneSyncSvc,RemoteAccess,shpamsvc,DPS
REM -
REM Edit and use with caution, don't go blindly deleting/disabling services or your OS may end up not working.
REM OneSyncSvc = OneDrive - so if you use that service DON'T stop/delete!
REM -
REM Look through this section as this can affect certain Apps also the deleted services cannot be reverted!
REM -
REM If you wish to use the below sections delete the GOTO :AdvFirewallBlocks line below. There is Two of them!

REM Special services that have different numbers on the end per install.
for /f "delims=" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "CDPUserSvc_*" ^| find "CDPUserSvc"') do reg add "%%S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
for /f "delims=" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "PimIndexMaintenanceSvc_*" ^| find "PimIndexMaintenanceSvc"') do reg add "%%S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
for /f "delims=" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "UnistoreSvc_*" ^| find "UnistoreSvc"') do reg add "%%S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1
for /f "delims=" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "UserDataSvc_*" ^| find "UserDataSvc"') do reg add "%%S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

GOTO :AdvFirewallBlocks

REM Turn off Clipboard History Service if variable set as Yes - RS5+
IF /I "%WinV%"=="10" (

IF /I "%TurnoffClipboardHistoryService%"=="Yes" (
 reg add "HKLM\System\CurrentControlSet\Services\cbdhsvc" /v "Start" /t REG_DWORD /d "4" /f
 reg add "HKCU\Software\Microsoft\Clipboard" /v "EnableClipboardHistory " /t REG_DWORD /d "0" /f
 reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "AllowCrossDeviceClipboard " /t REG_DWORD /d "0" /f
 reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "AllowClipboardHistory" /t REG_DWORD /d "0" /f
)

for /f "delims=" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /k /f "RetailDemo" ^| find "RetailDemo"') do reg add "%%S" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

SET "Services1=CertPropSvc,CscService,DiagTrack,DoSVC,PcaSvc,SCardSvr,SCPolicySvc,StiSvc,SysMain,TrkWks,WerSvc,Wecsvc,WMPNetworkSvc,WPCSvc,WSearch"
for /d %%S in (%Services1%) do sc config %%S start= disabled >NUL 2>&1
 
SET Services2=^
AITEventLog,AutoLogger-Diagtrack-Listener,DiagLog,EventLog-Microsoft-RMS-MSIPC-Debug,^
EventLog-Microsoft-Windows-WorkFolders-WHC,FamilySafetyAOT,LwtNetLog,Microsoft-Windows-Setup,^
NBSMBLOGGER,PEAuthLog,RdrLog,ReadyBoot,SetupPlatform,SQMLogger,TCPIPLOGGER,Tpm,WdiContextLog
 
 for /d %%S in (%Services2%) do reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\%%S" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>&1
 
 reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\Circular Kernel Context Logger" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>&1
 reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\WFP-IPsec Trace" /v "Start" /t REG_DWORD /d "0" /f >NUL 2>&1
 
 reg delete "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /f >NUL 2>&1
 reg delete "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\Diagtrack-Listener" /f >NUL 2>&1
 reg delete "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\Circular Kernel Context Logger" /f >NUL 2>&1
 reg delete "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\SQMLogger" /f >NUL 2>&1

REM ** Disabling possible unsafe services... **
SET "Services3=RemoteRegistry,TermService,TrkWks,SensorDataService,SensorService,SensrSvc"
  for %%S in (%Services3%) do (
   sc stop %%S >NUL 2>&1
   sc config %%S start= disabled >NUL 2>&1
  ) >NUL 2>&1

)

REM ** Remove 'GOTO :AdvFirewallBlocks' line to allow removal of the following services. Look up on the net about what the names do before blindly removing them **
REM WARNING this section may affect more Apps, be very careful what you do.

GOTO :AdvFirewallBlocks

REM ** Delete other possible 'spying' services... WARNING once these services are deleted you cannot reverse your actions, only by a repair or clean OS re-install **
IF /I "%WinV%"=="10" (
 set "MSspy_services=diagnosticshub.standardcollector.service,DcpSvc,WerSvc,PcaSvc,WMPNetworkSvc,XblAuthManager,XblGameSave,XboxNetApiSvc,xboxgip,wlidsvc,lfsvc,NcbService,WbioSrvc,MapsBroker,WalletService"
 for %%S in (%MSspy_services%) do (
  sc query %%S >NUL 2>&1
  if not errorlevel 1060 (
  sc stop %%S >NUL 2>&1
  sc delete %%S >NUL 2>&1
  ) >NUL 2>&1
 ) >NUL 2>&1
)

REM Set Restrict Background data to: {only if wifi is detected and enabled+logged into the network device.}
REM Always = 0x00000004
REM Never = 0x00000000
IF /I "%WinV%"=="10" (
	for /f %%W in ('%REGEXE% query "HKLM\SOFTWARE\Microsoft\DusmSvc\Profiles"') do (
		FOR /F %%X in ('%REGEXE% query "%%W"') DO %REGEXE% add "%%X" /v "BackgroundRestriction" /t REG_DWORD /d "0x00000004" /f >nul 2>&1
	)
)

REM ** end part **

:AdvFirewallBlocks
netsh advfirewall firewall add rule name="ContentDeliveryAdverts" action="block" dir="in" interface="any" program="%SystemDrive%\Windows\SystemApps\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\ContentDeliveryManager.Background.dll" Description="DisAllow ContentDelivery to connect in from the Internet." enable=yes >NUL 2>&1
netsh advfirewall firewall add rule name="ContentDeliveryAdverts" action="block" dir="out" interface="any" program="%SystemDrive%\Windows\SystemApps\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\ContentDeliveryManager.Background.dll" Description="DisAllow ContentDelivery to connect out to the Internet." enable=yes >NUL 2>&1
netsh advfirewall firewall add rule name="Block Windows Telemetry [DiagTrack]" dir="Out" action="Block" program="%SystemDrive%\windows\system32\svchost.exe" service="DiagTrack" protocol="TCP" remoteport=80,443 >nul 2>&1
netsh advfirewall firewall add rule name="Block Windows Error Reporting Service [WerSvc]" dir="Out" action="Block" program="%SystemDrive%\windows\system32\svchost.exe" service="WerSvc" protocol="TCP" remoteport=80,443 >nul 2>&1

reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "{60E6D465-398E-4850-BE86-7EF7620A2377}" /t REG_SZ /d "v2.24|Action=Block|Active=TRUE|Dir=Out|App=C:\windows\system32\svchost.exe|Svc=DiagTrack|Name=Windows Main Telemetry|" /f >NUL 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\FirewallRules" /v "{2765E0F4-2918-4A46-B9C9-43CDD8FCBA2B}" /t REG_SZ /d "v2.24|Action=Block|Active=TRUE|Dir=Out|App=C:\windows\systemapps\microsoft.windows.cortana_cw5n1h2txyewy\searchui.exe|Name=Search and Cortana applications|AppPkgId=S-1-15-2-1861897761-1695161497-2927542615-642690995-327840285-2659745135-2630312742|" /f >NUL 2>&1


REM WebRTC leak Fix
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="in" action="block" protocol="UDP" localport="3478" >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="in" action="block" protocol="UDP" remoteport=3478 >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="in" action="block" protocol="UDP" localport=19302 >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="in" action="block" protocol="UDP" remoteport=19302 >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="out" action="block" protocol="UDP" localport=3478 >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="out" action="block" protocol="UDP" remoteport=3478 >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="out" action="block" protocol="UDP" localport=19302 >nul 2>&1
netsh advfirewall firewall add rule name="WebRTC Leak Fix" dir="out" action="block" protocol="UDP" remoteport=19302 >nul 2>&1

REM Nasty Telemetry program that refuses to have its task killed and disabled, so block it via the Windows firewall !
netsh advfirewall firewall add rule name="Compatability Telemetry Runner" action="block" dir="in" interface="any" program="%SystemDrive%\windows\system32\CompatTelRunner.exe" Description="DisAllow CompatTelRunner to connect in from the Internet." enable=yes >NUL 2>&1
netsh advfirewall firewall add rule name="Compatability Telemetry Runner" action="block" dir="out" interface="any" program="%SystemDrive%\windows\system32\CompatTelRunner.exe" Description="DisAllow CompatTelRunner to connect out to the Internet." enable=yes >NUL 2>&1

REM SmartScreen Firewall Blocks
netsh advfirewall firewall add rule name="SmartScreen" action="block" dir="in" interface="any" program="%WinDir%\System32\smartscreen.exe" Description="DisAllow SmartScreen to connect in from the Internet." enable=yes >NUL 2>&1
netsh advfirewall firewall add rule name="SmartScreen" action="block" dir="out" interface="any" program="%WinDir%\System32\smartscreen.exe" Description="DisAllow SmartScreen to connect out to the Internet." enable=yes >NUL 2>&1

REM Use Firewall rules to block known Telemetry IP addresses. Will not be complete as they add them all the time, but it is a starting point.
netsh advfirewall firewall add rule name="telemetry_vortex.data.microsoft.com" dir="Out" action="block" remoteip=191.232.139.254 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_telecommand.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.55.252.92 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_oca.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.55.252.63 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_sqm.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.55.252.93 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_watson.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.55.252.43,65.52.108.29 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_redir.metaservices.microsoft.com" dir="Out" action="block" remoteip=194.44.4.200,194.44.4.208 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_choice.microsoft.com" dir="Out" action="block" remoteip=157.56.91.77 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.7 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_reports.wes.df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.91 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_wes.df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.93 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_services.wes.df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.92 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_sqm.df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.94 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.9 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_watson.ppe.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.11 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_telemetry.appex.bing.net" dir="Out" action="block" remoteip=168.63.108.233 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_telemetry.urs.microsoft.com" dir="Out" action="block" remoteip=157.56.74.250 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_settings-sandbox.data.microsoft.com" dir="Out" action="block" remoteip=111.221.29.177 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_vortex-sandbox.data.microsoft.com" dir="Out" action="block" remoteip=64.4.54.32 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_survey.watson.microsoft.com" dir="Out" action="block" remoteip=207.68.166.254 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_watson.live.com" dir="Out" action="block" remoteip=207.46.223.94 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_watson.microsoft.com" dir="Out" action="block" remoteip=65.55.252.71 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_statsfe2.ws.microsoft.com" dir="Out" action="block" remoteip=64.4.54.22 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_corpext.msitadfs.glbdns2.microsoft.com" dir="Out" action="block" remoteip=131.107.113.238 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_compatexchange.cloudapp.net" dir="Out" action="block" remoteip=23.99.10.11 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_a-0001.a-msedge.net" dir="Out" action="block" remoteip=204.79.197.200 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_statsfe2.update.microsoft.com.akadns.net" dir="Out" action="block" remoteip=64.4.54.22 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_sls.update.microsoft.com.akadns.net" dir="Out" action="block" remoteip=157.56.77.139 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_fe2.update.microsoft.com.akadns.net" dir="Out" action="block" remoteip=134.170.58.121,134.170.58.123,134.170.53.29,66.119.144.190,134.170.58.189,134.170.58.118,134.170.53.30,134.170.51.190 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_diagnostics.support.microsoft.com" dir="Out" action="block" remoteip=157.56.121.89 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_corp.sts.microsoft.com" dir="Out" action="block" remoteip=131.107.113.238 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_statsfe1.ws.microsoft.com" dir="Out" action="block" remoteip=134.170.115.60 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_pre.footprintpredict.com" dir="Out" action="block" remoteip=204.79.197.200 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_i1.services.social.microsoft.com" dir="Out" action="block" remoteip=104.82.22.249 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_feedback.windows.com" dir="Out" action="block" remoteip=134.170.185.70 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_feedback.microsoft-hohm.com" dir="Out" action="block" remoteip=64.4.6.100,65.55.39.10 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_feedback.search.microsoft.com" dir="Out" action="block" remoteip=157.55.129.21 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_rad.msn.com" dir="Out" action="block" remoteip=207.46.194.25 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_preview.msn.com" dir="Out" action="block" remoteip=23.102.21.4 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_dart.l.doubleclick.net" dir="Out" action="block" remoteip=173.194.113.220,173.194.113.219,216.58.209.166 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_ads.msn.com" dir="Out" action="block" remoteip=157.56.91.82,157.56.23.91,104.82.14.146,207.123.56.252,185.13.160.61,8.254.209.254 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_a.ads1.msn.com" dir="Out" action="block" remoteip=198.78.208.254,185.13.160.61 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_global.msads.net.c.footprint.net" dir="Out" action="block" remoteip=185.13.160.61,8.254.209.254,207.123.56.252 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_oca.telemetry.microsoft.com.nsatc.net" dir="Out" action="block" remoteip=65.55.252.63 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_reports.wes.df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.91 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_df.telemetry.microsoft.com" dir="Out" action="block" remoteip=65.52.100.7 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_vortex-sandbox.data.microsoft.com" dir="Out" action="block" remoteip=64.4.54.32 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_pre.footprintpredict.com" dir="Out" action="block" remoteip=204.79.197.200 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_i1.services.social.microsoft.com" dir="Out" action="block" remoteip=104.82.22.249 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_ssw.live.com" dir="Out" action="block" remoteip=207.46.101.29 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_statsfe1.ws.microsoft.com" dir="Out" action="block" remoteip=134.170.115.60 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_msnbot-65-55-108-23.search.msn.com" dir="Out" action="block" remoteip=65.55.108.23 enable=yes >nul 2>&1
netsh advfirewall firewall add rule name="telemetry_a23-218-212-69.deploy.static.akamaitechnologies.com" dir="Out" action="block" remoteip=23.218.212.69 enable=yes >nul 2>&1

:RefreshDNS
nbtstat -R >NUL 2>&1
ipconfig /flushdns >NUL 2>&1
net stop dnscache >NUL 2>&1
net start dnscache >NUL 2>&1

REM Delete this CompatTelRunner.exe pest by force.  Its been blocked by firewall rules, had its tasks disabled and it will also re-attempt
REM to turn back itself back on, so remove the file, tasks and registry entries as well.  
REM SFC will replace this file from winSXS folder so be careful.
REM You will have to remove this pesky file every CU/OS Upgrade, or SFC /SCANNOW operation as it will always return.
 
netsh advfirewall firewall add rule name="Compatability Telemetry Runner" action="block" dir="in" interface="any" program="%SystemDrive%\windows\system32\CompatTelRunner.exe" Description="DisAllow CompatTelRunner to connect in from the Internet." enable=yes >NUL 2>&1
netsh advfirewall firewall add rule name="Compatability Telemetry Runner" action="block" dir="out" interface="any" program="%SystemDrive%\windows\system32\CompatTelRunner.exe" Description="DisAllow CompatTelRunner to connect out to the Internet." enable=yes >NUL 2>&1

IF EXIST "%WinDir%\System32\CompatTelRunner.exe" (
 schtasks /END /TN "Microsoft\Windows\Autochk\Proxy" >NUL 2>&1
 schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable >NUL 2>&1
 
 2>nul SCHTASKS /query | findstr /B /I "Microsoft Compatibility Appraiser" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "Microsoft Compatibility Appraiser" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >NUL 2>&1

 2>nul SCHTASKS /query | findstr /B /I "ProgramDataUpdater" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "ProgramDataUpdater" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >NUL 2>&1

 2>nul SCHTASKS /query | findstr /B /I "StartupAppTask" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\StartupAppTask" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "StartupAppTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable >NUL 2>&1

 2>nul SCHTASKS /query | findstr /B /I "AITAgent" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\AITAgent" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "AITAgent" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\AITAgent" /Disable >NUL 2>&1

 2>nul SCHTASKS /query | findstr /B /I "Consolidator" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\Consolidator" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "Consolidator" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\Consolidator" /Disable >NUL 2>&1

 2>nul SCHTASKS /query | findstr /B /I "KernelCEIPTask" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\KernelCEIPTask" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "KernelCEIPTask" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\KernelCEIPTask" /Disable >NUL 2>&1

 2>nul SCHTASKS /query | findstr /B /I "UsbCEIP" >NUL 2>&1 && schtasks /END /TN "Microsoft\Windows\Application Experience\UsbCEIP" >NUL 2>&1
 2>nul SCHTASKS /query | findstr /B /I "UsbCEIP" >NUL 2>&1 && SCHTASKS /Change /TN "Microsoft\Windows\Application Experience\UsbCEIP" /Disable >NUL 2>&1

 reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" /f >NUL 2>&1
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Appraiser" /v "HaveUploadedForTarget" /t REG_DWORD /d "1" /f >NUL 2>&1
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\AIT" /v "AITEnable" /t REG_DWORD /d "0" /f >NUL 2>&1

 reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /f >NUL 2>&1
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v "DontRetryOnError" /t REG_DWORD /d "1" /f >NUL 2>&1
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v "IsCensusDisabled" /t REG_DWORD /d "1" /f >NUL 2>&1
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\ClientTelemetry" /v "TaskEnableRun" /t REG_DWORD /d "1" /f >NUL 2>&1

 for %%i in (InstallInfoCheck,ARPInfoCheck,MediaInfoCheck,FileInfoCheck) do reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Tracing" /v "%%i" /t REG_DWORD /d "0" /f >NUL 2>&1

 reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags" /v "UpgradeEligible" /f >NUL 2>&1
 reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\TelemetryController" /f >NUL 2>&1

 schtasks /Change /DISABLE /TN "Microsoft\Windows\SetupSQMTask" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\TelTask" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Application Experience\AitAgent" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" >NUL 2>&1
 schtasks /Change /DISABLE /TN "Microsoft\Windows\PerfTrack\BackgroundConfigSurveyor" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\SetupSQMTask" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Customer Experience Improvement Program\BthSQM" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Customer Experience Improvement Program\TelTask" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\Application Experience\AitAgent" >NUL 2>&1
 schtasks /Delete /F /TN "Microsoft\Windows\PerfTrack\BackgroundConfigSurveyor" >NUL 2>&1
 
 reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CompatTelRunner.exe" /v "Debugger" /t REG_SZ /d "%SystemRoot%\system32\systray.exe" /f >NUL 2>&1
)

IF EXIST "%WinDir%\System32\CompatTelRunner.exe" (
	takeown /f "%WinDir%\System32\CompatTelRunner.exe" /a >NUL 2>&1
	icacls "%WinDir%\System32\CompatTelRunner.exe" /grant:r *S-1-5-32-544:F /c >NUL 2>&1
	taskkill /im CompatTelRunner.exe /f >NUL 2>&1
	timeout /t 1 >nul
	del "%WinDir%\System32\CompatTelRunner.exe" /f /q >NUL 2>&1
)

REM delete 'GOTO :WinTelDone' line to stop search indexing, more so for SSD's to prevent un-needed wear.
GOTO :WinTelDone

REM disable search indexing
sc config WSearch start= disabled >NUL 2>&1
sc stop WSearch >NUL 2>&1
sc config SysMain start= disabled >NUL 2>&1
sc stop SysMain >NUL 2>&1

REM Windows Search
Reg add "HKLM\SYSTEM\CurrentControlSet\Services\Wsearch" /v "Start" /t REG_DWORD /d "4" /f >NUL 2>&1
Reg add "HKLM\SYSTEM\ControlSet001\Services\Wsearch" /v "Start" /t REG_DWORD /d "4" /f >NUL 2>&1
REG add "HKLM\SYSTEM\CurrentControlSet\services\SysMain" /v "Start" /t REG_DWORD /d "4" /f >NUL 2>&1

REM Index bit...
Reg add "HKLM\SYSTEM\CurrentControlSet\Services\cisvc" /v "Start" /t REG_DWORD /d "4" /f >NUL 2>&1
Reg add "HKLM\SYSTEM\ControlSet001\Services\cisvc" /v "Start" /t REG_DWORD /d "4" /f >NUL 2>&1

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowIndexingEncryptedStoresOrItems" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\PrimaryProperties\UnindexedLocations" /v "SearchOnly" /t REG_DWORD /d "0" /f >NUL 2>&1

Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "SystemFolders" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "AutoWildCard" /t REG_DWORD /d "1" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "EnableNaturalQuerySyntax" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "WholeFileSystem" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences" /v "ArchivedFiles" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{352481E8-33BE-4251-BA85-6007CAEDCF9D}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{62AB5D82-FDC1-4DC3-A9DD-070D1D495D97}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{6365D5A7-0F0D-45e5-87F6-0DA56B6A4F7D}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{6D809377-6AF0-444b-8957-A3773F02200E}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{905E63B6-C1BF-494E-B29C-65B732D3D21A}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{D9DC8A3B-B784-432E-A781-5A1130A75963}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{DE974D24-D9C6-4D3E-BF91-F4455120B917}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{F38BF404-1D43-42F2-9305-67DE0B28FC23}" /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Search\Preferences\ExcludeSystemFolders" /v "{F7F1ED05-9F6D-47A2-AAAE-29D317C6F066}" /t REG_SZ /d "" /f >NUL 2>&1

:WinTelDone
REM If task setup then delete that now.
SCHTASKS /query | findstr /B /I "_WinTel_Runonce" >NUL 2>&1 && "schtasks.exe" /Delete /TN "_WinTel_Runonce" /F >NUL 2>&1
IF /I "%errorlevel%" NEQ "0" set "ErrCode=%errorlevel%"
DEL /F /Q "%0%" >NUL 2>&1
