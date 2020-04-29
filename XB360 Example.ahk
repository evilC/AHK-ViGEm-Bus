#SingleInstance force
#include Lib\AHK-ViGEm-Bus.ahk

; Create a new Xbox 360 controller
controller := new ViGEmXb360()
return

; === Buttons
1::
	controller.Buttons.A.SetState(true)
	return

1 up::
	controller.Buttons.A.SetState(false)
	return

2::
	controller.Buttons.B.SetState(true)
	return

2 up::
	controller.Buttons.B.SetState(false)
	return

3::
	controller.Buttons.X.SetState(true)
	return

3 up::
	controller.Buttons.X.SetState(false)
	return

4::
	controller.Buttons.Y.SetState(true)
	return

4 up::
	controller.Buttons.Y.SetState(false)
	return

5::
	controller.Buttons.LB.SetState(true)
	return

5 up::
	controller.Buttons.LB.SetState(false)
	return

6::
	controller.Buttons.RB.SetState(true)
	return

6 up::
	controller.Buttons.RB.SetState(false)
	return

7::
	controller.Buttons.Back.SetState(true)
	return

7 up::
	controller.Buttons.Back.SetState(false)
	return

8::
	controller.Buttons.Start.SetState(true)
	return

8 up::
	controller.Buttons.Start.SetState(false)
	return

9::
	controller.Buttons.LS.SetState(true)
	return

9 up::
	controller.Buttons.LS.SetState(false)
	return

0::
	controller.Buttons.RS.SetState(true)
	return

0 up::
	controller.Buttons.RS.SetState(false)
	return

Space::
	controller.Buttons.Xbox.SetState(true)
	return

Space Up::
	controller.Buttons.Xbox.SetState(false)
	return
; === Axes
; == Left Stick
w::
	controller.Axes.LY.SetState(100)
	return

s::
	controller.Axes.LY.SetState(0)
	return

w up::
s up::
	controller.Axes.LY.SetState(50)
	return

a::
	controller.Axes.LX.SetState(0)
	return

d::
	controller.Axes.LX.SetState(100)
	return

a up::
d up::
	controller.Axes.LX.SetState(50)
	return

; == Right Stick
i::
	controller.Axes.RY.SetState(100)
	return

k::
	controller.Axes.RY.SetState(0)
	return

i up::
k up::
	controller.Axes.RY.SetState(50)
	return

j::
	controller.Axes.RX.SetState(0)
	return

l::
	controller.Axes.RX.SetState(100)
	return

j up::
l up::
	controller.Axes.RX.SetState(50)
	return

; === Dpad
Numpad8::
	controller.Dpad.SetState("Up")
	return

Numpad9::
	controller.Dpad.SetState("UpRight")
	return

Numpad6::
	controller.Dpad.SetState("Right")
	return

Numpad3::
	controller.Dpad.SetState("DownRight")
	return

Numpad2::
	controller.Dpad.SetState("Down")
	return

Numpad1::
	controller.Dpad.SetState("DownLeft")
	return

Numpad4::
	controller.Dpad.SetState("Left")
	return

Numpad7::
	controller.Dpad.SetState("UpLeft")
	return

Numpad8 up::
Numpad9 up::
Numpad6 up::
Numpad3 up::
Numpad2 up::
Numpad1 up::
Numpad4 up::
Numpad7 up::
	controller.Dpad.SetState("None")
	return

^Esc::
	ExitApp