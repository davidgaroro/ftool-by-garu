
Func _OnButtonStart()
  ; Get input values from controlsID
  Local $sCheckWindow = GUICtrlRead(@GUI_CtrlId + 2)
  Local $sCheckInterval = GUICtrlRead(@GUI_CtrlId + 4)
  Local $sCheckFKey = GUICtrlRead(@GUI_CtrlId + 6)
  Local $sCheckSkill = GUICtrlRead(@GUI_CtrlId + 8)
  Local $sSpammerFile = @ScriptDir & "\Subfiles\Spammer.exe"

  ; Check if interval has value otherwise set inverval to 0
  If $sCheckInterval = "" Then GUICtrlSetData(@GUI_CtrlId + 4, 0)
    
  ; Validate input data
  Select
    ; Check if Spammer.exe exists
    Case FileExists($sSpammerFile) = 0
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, $sSpammerFile, "Windows cannot find " & @CRLF & "'" & $sSpammerFile & "'.")
      Return

    ; Check if window has been selected
    Case $sCheckWindow = $g_sSelectWindow
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, $g_sSelectWindow, "Select a Flyff window.")
      Return

    ; Check if window still exists
    Case WinExists($sCheckWindow) = 0
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, $sCheckWindow, "Selected Flyff window doesn't exist.")
      Return

    ; Check if fkey or skill has been selected
    Case $sCheckFKey = " " And $sCheckSkill = " "
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, "Validation Error", "Select atleast one F-Key or Skill Bar.")
      Return
  EndSelect

  ; TODO: Toggle buttons and disable controls
  ; TODO: Run script with skill, key, interval and PID params
EndFunc   ;==>_OnButtonStart
