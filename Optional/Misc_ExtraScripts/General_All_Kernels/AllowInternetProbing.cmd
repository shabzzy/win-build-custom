@echo off
CLS
color 1f
TITLE Checking for Admin...
echo.
cd %systemroot%\system32
call :IsAdmin

:StartScript
TITLE Allow Internet/Test Probing...
cls
color 1f
echo.
SET /p "AllowIP=Do you wish to allow Internet Probing ? {Y/N} "
echo.
IF /I "%AllowIP%" NEQ "Y" echo No changes made. & echo. & GOTO :Done

echo Updating registry...

Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /ve /t REG_SZ /d "" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "NoActiveProbe" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "DisablePassivePolling" /t REG_DWORD /d "0" /f >NUL 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator" /v "EnableActiveProbing" /t REG_DWORD /d "1" /f >NUL 2>&1
REG add "HKLM\SOFTWARE\POLICIES\MICROSOFT\Windows\NetworkConnectivityStatusIndicator" /v "UseGlobalDNS" /t REG_DWORD /d "1" /f >NUL 2>&1

REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeContent" /t REG_SZ /d "131.107.255.255" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeContentV6" /t REG_SZ /d "fd3e:4f5a:5b81::1" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeHost" /t REG_SZ /d "dns.msftncsi.com" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveDnsProbeHostV6" /t REG_SZ /d "dns.msftncsi.com" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveWebProbeContent" /t REG_SZ /d "Microsoft NCSI" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveWebProbeContentV6" /t REG_SZ /d "Microsoft NCSI" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveWebProbeHost" /t REG_SZ /d "www.msftncsi.com" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveWebProbeHostV6" /t REG_SZ /d "ipv6.msftncsi.com" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveWebProbePath" /t REG_SZ /d "ncsi.txt" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "ActiveWebProbePathV6" /t REG_SZ /d "ncsi.txt" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "EnableActiveProbing" /t REG_DWORD /d "1" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "PassivePollPeriod" /t REG_DWORD /d "5" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "StaleThreshold" /t REG_DWORD /d "30" /f
REG add "HKLM\SYSTEM\CurrentControlSet\services\NlaSvc\Parameters\Internet" /v "WebTimeout" /t REG_DWORD /d "35" /f
REG add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "MinimumInternetHopCount" /t REG_DWORD /d "2" /f >NUL 2>&1
Reg add "HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet" /v "WebTimeout" /t REG_DWORD /d "35" /f >NUL 2>&1

2>nul ROUTE delete 131.107.255.255 >nul
2>nul ROUTE delete 131.253.40.37 >nul
2>nul ROUTE delete 131.253.40.44 >nul

ipconfig /flushdns >NUL 2>&1

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
