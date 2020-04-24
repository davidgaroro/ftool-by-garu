#RequireAdmin
#include <GUIConstantsEx.au3>

; AutoItSetOption
Opt("GuiOnEventMode", 1) ; Change to OnEvent mode
Opt("TrayMenuMode", 1) ; Disable default tray menu
Opt("TrayOnEventMode", 1) ; Enable OnEvent functions notifications for the tray

; General Declarations
Global $title = "FTool by Garu"

; Create GUI window
Local $hMainGUI = GUICreate($title, 298, 463)

; Display the GUI
GUISetState(@SW_SHOW, $hMainGUI)

; Register the close event handler
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

; Create a tray exit option
TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "_Exit")

; Loop until the user exits
While 1
	Sleep(100) ; Sleep to reduce CPU usage
WEnd

Func _Exit()
	Exit
EndFunc   ;==>_Exit
