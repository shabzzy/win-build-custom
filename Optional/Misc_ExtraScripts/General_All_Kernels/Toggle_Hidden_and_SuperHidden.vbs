Dim isHidden, NormalHidden, SuperHidden, ShowSuperHidden
Dim WshShell

On Error Resume Next


NormalHidden = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden"
SuperHidden = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\SuperHidden"

ShowSuperHidden = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden"


Set WshShell = WScript.CreateObject("WScript.Shell")

isHidden = WshShell.RegRead(NormalHidden)


If isHidden = 2 Then 'currently hidden
	WshShell.RegWrite NormalHidden, 1, "REG_DWORD"

	WshShell.RegWrite SuperHidden, 1, "REG_DWORD"
	WshShell.RegWrite ShowSuperHidden, 1, "REG_DWORD"
	WshShell.Popup "Hidden and Super Hidden files will be shown, refresh explorer.",, "Toggle Hidden/SuperHidden", 48

Else	'not currently hidden

	WshShell.RegWrite NormalHidden, 2, "REG_DWORD"
	WshShell.RegWrite SuperHidden, 0, "REG_DWORD"

	WshShell.RegWrite ShowSuperHidden, 0, "REG_DWORD"
	WshShell.Popup "Hidden and Super Hidden files will NOT be shown, refresh explorer.",, "Toggle Hidden/SuperHidden", 48

End If
