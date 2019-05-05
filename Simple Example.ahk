#SingleInstance force
#include Include\AHK-ViGEm-Bus.ahk

; Create a new DS4 controller
ds4 := new ViGEmDS4()

; Create a new Xbox 360 controller
;~ xb360 := new ViGEmXb360()
return

F11::
	;~ xb360
		;~ .SetAxisState(XbAxes.LX, -32768)
		;~ .SendReport()
	return

F12::
	; Press button 1 on both controllers
	;~ xb360
		;~ .SetButtonState(XbButtons.A, true)
		;~ .SetAxisState(XbAxes.LX, 32767)
		;~ .SendReport()
	ds4.SetButtonState(DS4Buttons.Square, true)
		.SendReport()
	return

F11 up::
F12 up::
	; Release button 1 on both controllers
	;~ xb360
		;~ .SetButtonState(XbButtons.A, false)
		;~ .SetAxisState(XbAxes.LX, 0)
		;~ .SendReport()
	ds4.SetButtonState(DS4Buttons.Square, false)
		.SendReport()
	return

^Esc::
	ExitApp