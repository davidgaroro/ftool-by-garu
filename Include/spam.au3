
Func _OnButtonClick()

  ; Get input controlID
  Local $iButtonCtrlId = @GUI_CtrlId
  Local $iWindowCtrlId = @GUI_CtrlId + 2
  Local $iIntervalCtrlId = @GUI_CtrlId + 4
  Local $iFKeyCtrlId = @GUI_CtrlId + 6
  Local $iSkillCtrlId = @GUI_CtrlId + 8

  ; Get timer state
  Local $bTimer = (GUICtrlRead($iButtonCtrlId) = "Stop") 

  If $bTimer = true Then
    ; Stop Spammer.exe process
    ; TODO: ProcessClose(Spammer PID)

    ; Enable controls
    GUICtrlSetData($iButtonCtrlId, "Start")
    GUICtrlSetState($iWindowCtrlId, $GUI_ENABLE)
    GUICtrlSetState($iIntervalCtrlId, $GUI_ENABLE)
    GUICtrlSetState($iFKeyCtrlId, $GUI_ENABLE)
    GUICtrlSetState($iSkillCtrlId, $GUI_ENABLE)
    Return
  EndIf

  ; Get input data
  Local $sCheckWindow = GUICtrlRead($iWindowCtrlId)
  Local $iCheckInterval = GUICtrlRead($iIntervalCtrlId)
  Local $sCheckFKey = GUICtrlRead($iFKeyCtrlId)
  Local $sCheckSkill = GUICtrlRead($iSkillCtrlId)
  Local $sSpammerFile = @ScriptDir & "\Subfiles\Spammer.exe"

  ; Check if interval has value otherwise set inverval to 0
  If $iCheckInterval = "" Then GUICtrlSetData(@GUI_CtrlId + 4, 0)
    
  ; Validate input data
  Select
    ; Check if Spammer.exe file exists
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

  ; Disable controls
  GUICtrlSetData($iButtonCtrlId, "Stop")
  GUICtrlSetState($iWindowCtrlId, $GUI_DISABLE)
  GUICtrlSetState($iIntervalCtrlId, $GUI_DISABLE)
  GUICtrlSetState($iFKeyCtrlId, $GUI_DISABLE)
  GUICtrlSetState($iSkillCtrlId, $GUI_DISABLE)

  ; TODO: Run script with skill, key, interval and PID params
EndFunc   ;==>_OnButtonClick
