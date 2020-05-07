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
  Local $aArrayTmp[$iProccessCount] ; Temporary array

  Local $sWindowTitle = ""
	For $i = 1 To $iProccessCount ; Loop Neuz.exe list
    For $j = 1 To $aWinList[0][0] ; Loop windows handles list
      $sWindowTitle = $aWinList[$j][0]
			; If windows have title
			If $sWindowTitle <> "" Then
				; Compare matching PIDs
				If WinGetProcess($sWindowTitle) = $aProcessList[$i][1] Then
          $sComboWindowsData &= "|" & $sWindowTitle ; Combo data
          $aArrayTmp[$i - 1] = $sWindowTitle  ; Temporary array
					ExitLoop
				EndIf
			EndIf
		Next
  Next
  
  ; Assign new array to windows array
  $g_aWindows = $aArrayTmp

  ; Update select window data
	GUICtrlSetData($iIDFrom, $sComboWindowsData, $g_sSelectWindow)
EndFunc   ;==>_GetNeuzWindows


Func _CheckWindowsExists()
  For $i = 0 To UBound($g_aWindows) - 1
    ; If window title doesn't exists
    If WinExists($g_aWindows[$i]) = 0 Then
      ; Stop timers from that window title
      For $j = 0 to UBound($g_aSpammers) - 1
        If $g_aSpammers[$j][$g_eSpamWindowTitle] = $g_aWindows[$i] Then
          _SpamStop($j)
        EndIf
      Next
    EndIf
  Next
EndFunc   ;==>_CheckWindowsExists
