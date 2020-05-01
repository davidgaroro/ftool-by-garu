#RequireAdmin
#include "Include\Constants.au3"
#include "Include\Spam.au3"
#include "Include\Windows.au3"

; AutoItSetOption
Opt("GuiOnEventMode", 1) ; Change to OnEvent mode
Opt("TrayMenuMode", 1) ; Disable default tray menu
Opt("TrayOnEventMode", 1) ; Enable OnEvent functions notifications for the tray

; General Declarations
Local const $sTitle = "FTool by Garu", $iWinWidth = 298, $iWinHeight = 522

; Spammer variables
Local const $iTabsCount = 4, $iTabsSpammers = 5
Global Enum $g_eSpamWindow, $g_eSpamPID
Global $g_aSpammers[$iTabsCount * $iTabsSpammers][2] ; Save spammers controls
Global const $g_sSelectWindow = "Select Window"

; Create GUI window
Local $hMainGUI = GUICreate($sTitle, $iWinWidth, $iWinHeight) 

; Register the close event handler
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

; Create a tray exit option
TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "_Exit")

#Region TABS & SPAMMERS
	GUICtrlCreateTab(0, 0, $iWinWidth + 2, $iWinHeight + 1)

	; GUI variables
	Local Const $iSpace=99, $iCol1=98, $iCol2=245

	Local $jCount = 0
	For $i = 1 To $iTabsCount
		GUICtrlCreateTabItem("Spammer " & $i)
			
		For $j = 0 To $iTabsSpammers - 1
			GUICtrlCreateGroup("", 6, 20 + ($j * $iSpace), 286, 101)
			
			; Hidden label to save spammer index
			GUICtrlCreateLabel($jCount, -99, -99)
			GUICtrlSetState(-1, $GUI_HIDE)

			; Start button
			GUICtrlCreateButton("Start", 13, 35 + ($j * $iSpace), 76, 76)
			GUICtrlSetOnEvent(-1, "_OnButtonClick")

			; Select window
			GUICtrlCreateLabel("Window", $iCol1, 33 + ($j * $iSpace))
			$g_aSpammers[$jCount][$g_eSpamWindow] = GUICtrlCreateCombo($g_sSelectWindow, $iCol1, 48 + ($j * $iSpace), 138, 20, $CBS_DROPDOWNLIST)

			; Interval
			GUICtrlCreateLabel("Interval (ms)", $iCol1, 75 + ($j * $iSpace))
			GUICtrlCreateInput("0", $iCol1, 90 + ($j * $iSpace), 138, 20, $ES_NUMBER)

			; F-Key
			GUICtrlCreateLabel("F-Key", $iCol2, 33 + ($j * $iSpace))
			GUICtrlCreateCombo(" ", $iCol2, 48 + ($j * $iSpace), 40, 20, $CBS_DROPDOWNLIST)
			GUICtrlSetData(-1, "F1|F2|F3|F4|F5|F6|F7|F8|F9")
			
			; Skill bar
			GUICtrlCreateLabel("Skill Bar", $iCol2, 75 + ($j * $iSpace))
			GUICtrlCreateCombo(" ", $iCol2, 90 + ($j * $iSpace), 40, 20, $CBS_DROPDOWNLIST)
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9")
			
			$jCount += 1
		Next
	Next
#EndRegion 

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND") ; Detect dropdown event

; Display the GUI
GUISetState(@SW_SHOW, $hMainGUI)

; Loop until the user exits
While 1
	Sleep(100) ; Sleep to reduce CPU usage
WEnd

Func _Exit()
	Exit
EndFunc   ;==>_Exit
