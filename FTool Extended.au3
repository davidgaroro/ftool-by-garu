#RequireAdmin

; AutoItSetOption
Opt("GuiOnEventMode", 1) ; Change to OnEvent mode
Opt("TrayMenuMode", 1) ; Disable default tray menu
Opt("TrayOnEventMode", 1) ; Enable OnEvent functions notifications for the tray

; General Declarations
Global const $sTitle = "FTool by Garu", $iTabsCount = 4, $iTabsSpammers = 4
Local const $iWinWidth = 298, $iWinHeight = 522

Local $hMainGUI = GUICreate($sTitle, $iWinWidth, $iWinHeight) ; Create GUI window
GUISetOnEvent(-3, "_Exit") ; Register the close event handler

; Create a tray exit option
TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "_Exit")

#Region TABS & SPAMMERS
	GUICtrlCreateTab(0, 0, $iWinWidth + 2, $iWinHeight + 1)

	; GUIControls variables
	Local Const $iSpace=99, $iCol1=98, $iCol2=245

	For $i = 1 To $iTabsCount
		GUICtrlCreateTabItem("Spammer " & $i)
			
		For $j = 0 To $iTabsSpammers
			GUICtrlCreateGroup("", 6, 20 + ($j * $iSpace), 286, 101)
			
			; Start Button
			GUICtrlCreateButton("Start", 13, 35 + ($j * $iSpace), 76, 76)

			; Select Window
			GUICtrlCreateLabel("Window", $iCol1, 33 + ($j * $iSpace))
			GUICtrlCreateCombo("Server Flyff - Character", $iCol1, 48 + ($j * $iSpace), 138, 20, BitOr(0x3, 0x0100))

			; Interval
			GUICtrlCreateLabel("Interval (ms)", $iCol1, 75 + ($j * $iSpace))
			GUICtrlCreateInput("500", $iCol1, 90 + ($j * $iSpace), 138, 20, 0x2000)

			; F-Key
			GUICtrlCreateLabel("F-Key", $iCol2, 33 + ($j * $iSpace))
			GUICtrlCreateCombo("F1", $iCol2, 48 + ($j * $iSpace), 40, 20, 0x3)

			; Skill Bar
			GUICtrlCreateLabel("Skill Bar", $iCol2, 75 + ($j * $iSpace))
			GUICtrlCreateCombo("1", $iCol2, 90 + ($j * $iSpace), 40, 20, 0x3)
			
			GUICtrlCreateGroup("", -99, -99, 1, 1) ; Close group
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
