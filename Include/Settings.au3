#include-once

Local Const $sFilePath = "Settings.ini"

Func _IniSave()
  Local $sSection = "", $sFKey, $sSkill
  For $i = 0 to UBound($g_aSpammers) - 1
    $sSection = "Spammer" & $i
    
    ; Check whitespace from fkey and skill
    $sFKey = GUICtrlRead($g_aSpammers[$i][$g_eSpamFKey])
    If $sFKey = " " Then $sFKey = ""

    $sSkill = GUICtrlRead($g_aSpammers[$i][$g_eSpamSkill])
    If $sSkill = " " Then $sSkill = ""

    ; Save window title, interval, FKey, Skill
    IniWrite($sFilePath, $sSection, "WindowTitle", GUICtrlRead($g_aSpammers[$i][$g_eSpamWindow]))
    IniWrite($sFilePath, $sSection, "Interval", GUICtrlRead($g_aSpammers[$i][$g_eSpamInterval]))
    IniWrite($sFilePath, $sSection, "FKey", $sFKey)
    IniWrite($sFilePath, $sSection, "Skill", $sSkill)
  Next
EndFunc ;==>_IniSave


Func _IniLoad()
  Local $sSection = "", $sWindowTitle, $iInterval, $sFKey, $sSkill

  For $i = 0 to UBound($g_aSpammers) - 1
    $sSection = "Spammer" & $i

    ; Set window title
    $sWindowTitle = IniRead($sFilePath, $sSection, "WindowTitle", $g_sSelectWindow)
    If $sWindowTitle = "" Then $sWindowTitle = $g_sSelectWindow
    GUICtrlSetData($g_aSpammers[$i][$g_eSpamWindow], $sWindowTitle, $sWindowTitle)
    
    ; Set interval
    $iInterval = Int(IniRead($sFilePath, $sSection, "Interval", "0"))
    GUICtrlSetData($g_aSpammers[$i][$g_eSpamInterval], $iInterval)
      
    ; Set fkey
    $sFKey = IniRead($sFilePath, $sSection, "FKey", " ")
    GUICtrlSetData($g_aSpammers[$i][$g_eSpamFKey], "F1|F2|F3|F4|F5|F6|F7|F8|F9", $sFKey)
    
    ; Set skill
    $sSkill = IniRead($sFilePath, $sSection, "Skill", " ")
    GUICtrlSetData($g_aSpammers[$i][$g_eSpamSkill], "1|2|3|4|5|6|7|8|9", $sSkill)
  Next
EndFunc ;==>_IniLoad
