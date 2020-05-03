; Disable tray menu
#NoTrayIcon

; Check if params are less then 5
If $CmdLine[0] <> 5 Then
	Exit
EndIf

; Get inputs data
Local $iMainPID = $CmdLine[1]
Local $hWindow = $CmdLine[2]
Local $iInterval = $CmdLine[3]
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
		_SendKey(48 + $sSkill)
		If $bFKey = True Then Sleep(150)
	EndIf
	If $bFKey = True Then
		; Send F-key to flyff window
		_SendKey(111 + $sFKey)
	EndIf
EndFunc   ;==>_Spam

Func _SendKey($iKey)
  DllCall("Functions.dll", "none", "fnPostMessage", "HWnd", $hWindow, "long", 256, "long", $iKey, "long", 0)
EndFunc   ;==>_SendKey

Local $hTimer = TimerInit() ; Begin the timer and store the handle in a variable
Local $fDiff = 0

While 1
	; Exit if main process does not exist
	If ProcessExists($iMainPID) = 0 Then
		Exit
	EndIf
	
	; Sleep to reduce CPU usage
	Sleep(100)

	; Find the difference in time from the previous call of TimerInit.
	$fDiff = TimerDiff($hTimer)

	; Spam keys
	If $fDiff >= ($iInterval * 1000) Then
		$hTimer = TimerInit()
		_Spam()
	EndIf
WEnd
