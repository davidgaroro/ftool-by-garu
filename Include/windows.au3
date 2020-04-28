
Func WM_COMMAND($hWnd, $iMsg, $wParam)

  Local $iCode = BitShift($wParam, 16) ; HiWord - this gives the message that was sent
  
  ; Exit if is not a dropdown event ($CBN_DROPDOWN = 7)
  If $iCode <> 7 Then Return

	Local $iIDFrom = BitAND($wParam, 0xFFFF) ; LoWord - this gives the control which sent the message
  
  ; Check if dropdown event is from window control
  Local $iSpamControl
  For $i = 0 To UBound($g_aSpamControls) - 1
    $iSpamControl = $g_aSpamControls[$i][$g_eSpamWindow]
    If $iIDFrom < $iSpamControl Then Return
    If $iIDFrom = $iSpamControl Then
      ; Update Neuz.exe windows list
      ConsoleWrite("GetNeuzWindows" & @CRLF)
      ExitLoop
    EndIf
  Next
EndFunc		;==>WM_COMMAND
