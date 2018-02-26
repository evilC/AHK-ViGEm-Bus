#SingleInstance force
#include Include\AHK-ViGEm-Bus.ahk

; Create a new DS4 controller
ds4 := new ViGEmDS4()

; Create a new Xbox 360 controller
xb360 := new ViGEmXb360()
return

F12::
	; Press button 1 on both controllers
	xb360.SetButtonState(0, true)
	xb360.SendReport()
	ds4.SetButtonState(0, true)
	ds4.SendReport()
	return

F12 up::
	; Release button 1 on both controllers
	xb360.SetButtonState(0, false)
	xb360.SendReport()
	ds4.SetButtonState(0, false)
	ds4.SendReport()
	return
