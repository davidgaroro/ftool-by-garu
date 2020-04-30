; Disable tray menu
#NoTrayIcon

; Check if params are less then 5
If $CmdLine[0] <> 5 Then
	Exit
EndIf

Local $iMainPID = $CmdLine[1]
Local $hWindow = $CmdLine[2]
Local $iCheckInterval = $CmdLine[3]
Local $sFKey = $CmdLine[4]
Local $sSkill = $CmdLine[5]

; Check if fkey and skill have been selected
Local $bFKey = ($sFKey <> " ")
Local $bSkill = ($sSkill <> " ")

; Delete F character from F-Keys to get the number
If $bFKey = True Then $sFKey = StringTrimLeft($sFKey, 1)

Func _Spam()
	If $bSkill = True Then
		; Send Skill number to flyff window
		DllCall("Functions.dll", "none", "fnPostMessage", "HWnd", $hWindow, "long", 256, "long", 48 + $sSkill, "long", 0)
		Sleep(150)
	EndIf
	If $bFKey = True Then
		; Send F-key to flyff window
		DllCall("Functions.dll", "none", "fnPostMessage", "HWnd", $hWindow, "long", 256, "long", 111 + $sFKey, "long", 0)
	EndIf
EndFunc   ;==>_Spam
