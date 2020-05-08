#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icons\AutoIt_Main_v11_256x256_RGB-A.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#RequireAdmin

#include "Include\Constants.au3"
#include "Include\Settings.au3"
#include "Include\Spam.au3"
#include "Include\Windows.au3"

; AutoItSetOption
Opt("GuiOnEventMode", 1) ; Change to OnEvent mode
Opt("TrayMenuMode", 1) ; Disable default tray menu
Opt("TrayOnEventMode", 1) ; Enable OnEvent functions notifications for the tray

; GUI Window variables
Local const $sTitle = "FTool by Garu 0.1", $iWinWidth = 286, $iWinHeight = 522, $iTabsCount = 4, $iTabsSpammers = 5

; Spammer variables
Global Enum $g_eSpamButton, $g_eSpamColor, $g_eSpamWindow, $g_eSpamInterval, $g_eSpamFKey, $g_eSpamSkill, $g_eSpamPID, $g_eSpamWindowTitle
Global $g_aSpammers[$iTabsCount * $iTabsSpammers][8]
Global const $g_sSelectWindow = "Select Window"

; Window variables
Global $g_aWindows[0]

; Create GUI window
Local $hMainGUI = GUICreate($sTitle, $iWinWidth, $iWinHeight) 

; Register close event handler
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

; Create a tray exit option
TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "_Exit")

#Region TABS & SPAMMERS
	GUICtrlCreateTab(0, 0, $iWinWidth + 2, $iWinHeight + 1)

	; GUI variables
	Local Const $iSpace=99, $iCol1=86, $iCol2=233, $iGroupColor = 0xF2F2F2

	Local $jCount = 0
	For $i = 1 To $iTabsCount
		GUICtrlCreateTabItem("Spammer " & $i)
			
		For $j = 0 To $iTabsSpammers - 1
			
			; Simulate group color
			$g_aSpammers[$jCount][$g_eSpamColor] =  GUICtrlCreateLabel("", 6, 27 + ($j * $iSpace), 273, 92) 
			GUICtrlSetBkColor(-1, $iGroupColor)
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetState(-1, $GUI_HIDE)
			
			GUICtrlCreateGroup("", 6, 20 + ($j * $iSpace), 274, 101)
			
			; Hidden label to save spammer index
			GUICtrlCreateLabel($jCount, -99, -99)
			GUICtrlSetState(-1, $GUI_HIDE)

			; Start button
			$g_aSpammers[$jCount][$g_eSpamButton] = GUICtrlCreateButton("Start", 13, 47 + ($j * $iSpace), 64, 64)
			GUICtrlSetOnEvent(-1, "_OnButtonClick")

			; Select window
			GUICtrlCreateLabel("Window", $iCol1, 33 + ($j * $iSpace))
			$g_aSpammers[$jCount][$g_eSpamWindow] = GUICtrlCreateCombo($g_sSelectWindow, $iCol1, 48 + ($j * $iSpace), 138, 20, $CBS_DROPDOWNLIST)

			; Interval
			GUICtrlCreateLabel("Interval (seconds)", $iCol1, 75 + ($j * $iSpace))
			$g_aSpammers[$jCount][$g_eSpamInterval] = GUICtrlCreateInput("0", $iCol1, 90 + ($j * $iSpace), 138, 20, $ES_NUMBER)

			; F-Key
			GUICtrlCreateLabel("F-Key", $iCol2, 33 + ($j * $iSpace))
			$g_aSpammers[$jCount][$g_eSpamFKey] = GUICtrlCreateCombo(" ", $iCol2, 48 + ($j * $iSpace), 40, 20, $CBS_DROPDOWNLIST)
			
			; Skill bar
			GUICtrlCreateLabel("Skill Bar", $iCol2, 75 + ($j * $iSpace))
			$g_aSpammers[$jCount][$g_eSpamSkill] = GUICtrlCreateCombo(" ", $iCol2, 90 + ($j * $iSpace), 40, 20, $CBS_DROPDOWNLIST)
			
			$jCount += 1
		Next
	Next
#EndRegion

; Detect dropdown events
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

_IniLoad() ; Read the INI file and get the saved values

; Display the GUI
GUISetState(@SW_SHOW, $hMainGUI)

; Loop until the user exits
While 1
	_CheckWindowsExists()
	Sleep(500) ; Sleep to reduce CPU usage
WEnd

Func _Exit()
	_IniSave() ; Save values to the INI file
	Exit
EndFunc   ;==>_Exit
