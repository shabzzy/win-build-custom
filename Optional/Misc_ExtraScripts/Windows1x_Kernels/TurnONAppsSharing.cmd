@Echo Off
Title Turn ON 'Share Across Devices for Apps'...
Color 1F
cd %systemroot%\system32
call :IsAdmin

Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "1" /f >NUL 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d "1" /f >NUL 2>&1
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d "1" /f >NUL 2>&1

Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d "1" /f >NUL 2>&1
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\CDP" /v "NearShareChannelUserAuthzPolicy" /t REG_DWORD /d "0" /f >NUL 2>&1
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\CDP" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d "1" /f >NUL 2>&1
Reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\CDP\SettingsPage" /v "RomeSdkChannelUserAuthzPolicy" /t REG_DWORD /d "1" /f >NUL 2>&1
Exit

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause & Exit
)
Cls
goto:eof
