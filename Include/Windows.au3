#include-once

Func WM_COMMAND($hWnd, $iMsg, $wParam)
  Local $iCode = BitShift($wParam, 16) ; HiWord - this gives the message that was sent

  If $iCode <> $CBN_DROPDOWN Then Return ; Exit if is not a dropdown event

  Local $iIDFrom = BitAND($wParam, 0xFFFF) ; LoWord - this gives the control which sent the message

  ; Check if dropdown event is from select window control
  Local $iSpamControl
  For $i = 0 To UBound($g_aSpammers) - 1
    $iSpamControl = $g_aSpammers[$i][$g_eSpamWindow]
    If $iIDFrom < $iSpamControl Then Return
    If $iIDFrom = $iSpamControl Then
      _GetNeuzWindows($iIDFrom)
      Return
    EndIf
  Next
EndFunc		;==>WM_COMMAND

Func _GetNeuzWindows($iIDFrom)
	$aProcessList = ProcessList("Neuz.exe") ; Get Neuz.exe list
  Local $iProccessCount = $aProcessList[0][0]
  
  If $iProccessCount = 0 Then Return ; Exit if there is no Neuz.exe
  
  Local $aWinList = WinList() ; Get windows handles list
	Local $sComboWindowsData = "|" & $g_sSelectWindow ; Use separator | at start to destroy previous list

	For $i = 1 To $iProccessCount ; Loop Neuz.exe list
		For $j = 1 To $aWinList[0][0] ; Loop windows handles list
			; If windows have title
			If $aWinList[$j][0] <> "" Then
				; Compare matching PIDs
				If WinGetProcess($aWinList[$j][0]) = $aProcessList[$i][1] Then
          $sComboWindowsData &= "|" & $aWinList[$j][0]
					ExitLoop
				EndIf
			EndIf
		Next
	Next

  ; Update select window data
	GUICtrlSetData($iIDFrom, $sComboWindowsData, $g_sSelectWindow)
EndFunc   ;==>_GetNeuzWindows
