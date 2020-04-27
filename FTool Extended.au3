#RequireAdmin

; AutoItSetOption
Opt("GuiOnEventMode", 1) ; Change to OnEvent mode
Opt("TrayMenuMode", 1) ; Disable default tray menu
Opt("TrayOnEventMode", 1) ; Enable OnEvent functions notifications for the tray

; General Declarations
Local const $sTitle = "FTool by Garu", $iWinWidth = 298, $iWinHeight = 522

; Spam variables
Local const $iTabsCount = 4, $iTabsSpammers = 5
Local Enum $eSpamButton, $eSpamWindow, $eSpamInterval, $eSpamFKey, $eSpamSBar
Local $aSpamControls[$iTabsCount * $iTabsSpammers][5] ; Save spammers controls

; Create GUI window
Local $hMainGUI = GUICreate($sTitle, $iWinWidth, $iWinHeight) 

; Register the close event handler
GUISetOnEvent(-3, "_Exit") 

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
			
			; Start Button
			$aSpamControls[$jCount][$eSpamButton] = GUICtrlCreateButton("Start", 13, 35 + ($j * $iSpace), 76, 76)

			; Select Window
			GUICtrlCreateLabel("Window", $iCol1, 33 + ($j * $iSpace))
			$aSpamControls[$jCount][$eSpamWindow] = GUICtrlCreateCombo("Server Flyff - Character" & $jCount, $iCol1, 48 + ($j * $iSpace), 138, 20, 0x3) ; $CBS_DROPDOWNLIST

			; Interval
			GUICtrlCreateLabel("Interval (ms)", $iCol1, 75 + ($j * $iSpace))
			$aSpamControls[$jCount][$eSpamInterval] = GUICtrlCreateInput("500", $iCol1, 90 + ($j * $iSpace), 138, 20, 0x2000)

			; F-Key
			GUICtrlCreateLabel("F-Key", $iCol2, 33 + ($j * $iSpace))
			$aSpamControls[$jCount][$eSpamFKey] = GUICtrlCreateCombo("F1", $iCol2, 48 + ($j * $iSpace), 40, 20, 0x3)

			; Skill Bar
			GUICtrlCreateLabel("Skill Bar", $iCol2, 75 + ($j * $iSpace))
			$aSpamControls[$jCount][$eSpamSBar] = GUICtrlCreateCombo("1", $iCol2, 90 + ($j * $iSpace), 40, 20, 0x3)
			
			$jCount += 1
		Next
	Next
#EndRegion 

; Display the GUI
GUISetState(@SW_SHOW, $hMainGUI) 

; Loop until the user exits
While 1
	Sleep(100) ; Sleep to reduce CPU usage
WEnd

Func _Exit()
	Exit
EndFunc   ;==>_Exit
