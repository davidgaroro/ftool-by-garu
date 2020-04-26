#RequireAdmin

; AutoItSetOption
Opt("GuiOnEventMode", 1) ; Change to OnEvent mode
Opt("TrayMenuMode", 1) ; Disable default tray menu
Opt("TrayOnEventMode", 1) ; Enable OnEvent functions notifications for the tray

; General Declarations
Global const $sTitle = "FTool by Garu"
Global const $iSpamCount = 4

Local $hMainGUI = GUICreate($sTitle, 298, 506) ; Create GUI window
GUISetBkColor(0xFFFFFF) ; Change background white color
GUISetOnEvent(-3, "_Exit") ; Register the close event handler

; Create a tray exit option
TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "_Exit")

; GUIControls variables
Local Const $iSpace=100, $iCol1=98, $iCol2=245

#Region Spammer
	For $i = 0 To $iSpamCount
		GUICtrlCreateGroup("", 5, ($i * $iSpace), 288, 102)

		; Create labels controls
		GUICtrlCreateLabel("Window", $iCol1, 13 + ($i * $iSpace))
		GUICtrlCreateLabel("F-Key", $iCol2, 13 + ($i * $iSpace))
		GUICtrlCreateLabel("Interval (ms)", $iCol1, 55 + ($i * $iSpace))
		GUICtrlCreateLabel("Skill Bar", $iCol2, 55 + ($i * $iSpace))
		
		GUICtrlCreateCombo("Flyff Name - Character", $iCol1, 28 + ($i * $iSpace), 138, 20, BitOr(0x3, 0x0100))
		GUICtrlCreateInput("500", $iCol1, 70 + ($i * $iSpace), 138, 20, 0x2000)
		
		; Create input controls
		GUICtrlCreateButton("Start", 14, 16 + ($i * $iSpace), 76, 76)
		GUICtrlCreateCombo("F1", $iCol2, 28 + ($i * $iSpace), 40, 20, 0x3)
		GUICtrlCreateCombo("1", $iCol2, 70 + ($i * $iSpace), 40, 20, 0x3)

		GUICtrlCreateGroup("", -99, -99, 1, 1) ; Close group
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
