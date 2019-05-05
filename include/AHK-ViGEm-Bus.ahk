#include %A_LineFile%\..\CLR.ahk

; Static class, holds ViGEm Client instance
class ViGEmWrapper {
	static asm := 0
	static client := 0
	
	Init(){
		if (this.client == 0){
			;~ this.asm := CLR_LoadLibrary(A_LineFile "\..\Nefarius.ViGEmClient.dll")
			this.asm := CLR_LoadLibrary(A_LineFile "\..\ViGEmWrapper.dll")
			;~ this.client := this.asm.CreateInstance("Nefarius.ViGEm.Client.ViGEmClient")
		}
	}
	
	CreateInstance(cls){
		return this.asm.CreateInstance(cls)
	}

}

XbButtons := {A: 4096, B: 8192, X: 16384, Y: 32768, LB: 256, RB: 512, Back: 32, Start: 64, DpadUp: 1, DpadDown: 2, DpadLeft: 3, DpadRight: 4}
XbAxes := {LX: 2, LY: 3, RX: 4, RY: 5, LT: 0, RT: 1}
DS4Buttons := {Square: 16, Cross: 32, Circle: 64, Triangle: 128, ShoulderLeft: 256, ShoulderRight: 512, TriggerLeft: 1024, TriggerRight: 2048
	, Share: 4096, Options: 8192, ThumbLeft: 16384, ThumbRight: 32768 }
Ds4Axes := {LX: 2, LY: 3, RX: 4, RY: 5, LT: 0, RT: 1}

; Base class for ViGEm "Targets" (Controller types - eg xb360 / ds4) to inherit from
class ViGEmTarget {
	target := 0
	helperClass := ""
	controllerClass := ""

	__New(){
		;~ this.asm := CLR_LoadLibrary(A_LineFile "\..\ViGEmWrapper.dll")
		ViGEmWrapper.Init()
		this.Instance := ViGEmWrapper.CreateInstance(this.helperClass)
		
		if (this.Instance.OkCheck() != "OK"){
			msgbox ViGEmWrapper.dll failed to load!
			ExitApp
		}
		
		/*
		ViGEmClient.Init()
		;~ this.target := CLR_CreateObject(ViGEmClient.asm, this.helperClass
			;~ , CLR_CreateObject(ViGEmClient.asm, this.controllerClass, ViGEmClient.client))
		this.Instance := CLR_CreateObject(ViGEmClient.asm, this.controllerClass, ViGEmClient.client)
		;~ this.report := CLR_CreateObject(ViGEmClient.asm, this.reportClass)
		this.report := ViGEmClient.asm.CreateInstance(this.reportClass)
		this.Instance.Connect()
		*/
	}
	
	SetAxisState(axis, state){
		;~ state := Floor((state - 50) * 655.35)
		;~ state *= 648.8712871287129
		
		this.Instance.SetAxisState(axis, state)
		;~ this.report.SetAxisState(axis, state)
		return this
	}

	SetButtonState(btn, state){
		;~ this.target.SetButtonState(btn, state)
		this.Instance.SetButtonState(btn, state)
		;~ this.report.SetButtonState(btn, state)
		return this
	}
	
	SendReport(){
		this.Instance.SendReport()
		return this
	}

}

; DS4-specific info (DualShock 4 for Playstation 4)
class ViGEmDS4 extends ViGEmTarget {
	;~ helperClass := "Nefarius.ViGEm.Client.Targets.DualShock4.DualShock4Helper"
	helperClass := "ViGEmWrapper.Ds4"
	;~ controllerClass := "Nefarius.ViGEm.Client.Targets.DualShock4Controller"
}

; Xb360-specific settings
class ViGEmXb360 extends ViGEmTarget {
	;~ helperClass := "Nefarius.ViGEm.Client.Targets.Xbox360.Xb360Helper"
	helperClass := "ViGEmWrapper.Xb360"
	;~ controllerClass := "Nefarius.ViGEm.Client.Targets.Xbox360Controller"
	;~ reportClass := "Nefarius.ViGEm.Client.Targets.Xbox360.Xbox360Report"
}