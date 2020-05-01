#include-once

Func _OnButtonClick()

  ; Get spammer index
  Local $iSpamIndex = GUICtrlRead(@GUI_CtrlId - 1)

  ; Get input controlID
  Local $iButtonCtrlId = @GUI_CtrlId
  Local $iWindowCtrlId = @GUI_CtrlId + 2
  Local $iIntervalCtrlId = @GUI_CtrlId + 4
  Local $iFKeyCtrlId = @GUI_CtrlId + 6
  Local $iSkillCtrlId = @GUI_CtrlId + 8

  ; Get timer state
  Local $bTimer = (GUICtrlRead($iButtonCtrlId) = "Stop") 

  If $bTimer = true Then
    ; Stop spammer.exe process
     ProcessClose($g_aSpammers[$iSpamIndex][$g_eSpamPID])
    $g_aSpammers[$iSpamIndex][$g_eSpamPID] = ""

    ; Enable controls
    GUICtrlSetData($iButtonCtrlId, "Start")
    GUICtrlSetState($iWindowCtrlId, $GUI_ENABLE)
    GUICtrlSetState($iIntervalCtrlId, $GUI_ENABLE)
    GUICtrlSetState($iFKeyCtrlId, $GUI_ENABLE)
    GUICtrlSetState($iSkillCtrlId, $GUI_ENABLE)
    Return
  EndIf

  ; Get input data
  Local $sWindow = GUICtrlRead($iWindowCtrlId)
  Local $iInterval = GUICtrlRead($iIntervalCtrlId)
  Local $sFKey = GUICtrlRead($iFKeyCtrlId)
  Local $sSkill = GUICtrlRead($iSkillCtrlId)
  Local $sSpammerFile = @ScriptDir & "\Subfiles\Spammer.exe"

  ; Check if interval has value otherwise set inverval to 0
  If $iInterval = "" Then
    $iInterval = 0
    GUICtrlSetData(@GUI_CtrlId + 4, 0)
  EndIf
    
  ; Validate input data
  Select
    ; Check if spammer.exe file exists
    Case FileExists($sSpammerFile) = 0
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, $sSpammerFile, "Windows cannot find " & @CRLF & "'" & $sSpammerFile & "'.")
      Return

    ; Check if window has been selected
    Case $sWindow = $g_sSelectWindow
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, $g_sSelectWindow, "Select a Flyff window.")
      Return

    ; Check if window still exists
    Case WinExists($sWindow) = 0
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, $sWindow, "Selected Flyff window doesn't exist.")
      Return

    ; Check if fkey or skill has been selected
    Case $sFKey = " " And $sSkill = " "
      MsgBox($MB_TASKMODAL + $MB_ICONERROR, "Validation Error", "Select atleast one F-Key or Skill Bar.")
      Return
  EndSelect

  ; Disable controls
  GUICtrlSetData($iButtonCtrlId, "Stop")
  GUICtrlSetState($iWindowCtrlId, $GUI_DISABLE)
  GUICtrlSetState($iIntervalCtrlId, $GUI_DISABLE)
  GUICtrlSetState($iFKeyCtrlId, $GUI_DISABLE)
  GUICtrlSetState($iSkillCtrlId, $GUI_DISABLE)

  ; Get main window PID
  Local $iMainPID = WinGetProcess($hMainGUI)

  ; Get flyff window handle
  Local $hWindow = WinGetHandle($sWindow)

  ; Run script with params: main window PID, flyff window handle, interval, fkey and skill bar
  Local $sParams = $iMainPID & ' "' & $hWindow & '" ' & $iInterval & ' "' & $sFKey & '" "' & $sSkill & '"'

  ; Save spammer.exe process PID
  $g_aSpammers[$iSpamIndex][$g_eSpamPID] = Run($sSpammerFile & ' ' & $sParams)
EndFunc   ;==>_OnButtonClick
