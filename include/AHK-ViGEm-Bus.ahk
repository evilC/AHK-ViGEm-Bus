#include %A_LineFile%\..\CLR.ahk

; Static class, holds ViGEm Client instance
class ViGEmClient {
	static asm := 0
	static client := 0
	
	Init(){
		if (this.client == 0){
			this.asm := CLR_LoadLibrary(A_LineFile "\..\Nefarius.ViGEmClient.dll")
			this.client := this.asm.CreateInstance("Nefarius.ViGEm.Client.ViGEmClient")
		}
	}
}

; Base class for ViGEm "Targets" (Controller types - eg xb360 / ds4) to inherit from
class ViGEmTarget {
	target := 0
	helperClass := ""
	controllerClass := ""

	__New(){
		ViGEmClient.Init()
		this.target := CLR_CreateObject(ViGEmClient.asm, this.helperClass
			, CLR_CreateObject(ViGEmClient.asm, this.controllerClass, ViGEmClient.client))
		this.target.Connect()
	}

	SetButtonState(btn, state){
		this.target.SetButtonState(btn, state)
	}
	
	SendReport(){
		this.target.SendReport()
	}

}

; DS4-specific info (DualShock 4 for Playstation 4)
class ViGEmDS4 extends ViGEmTarget {
	helperClass := "Nefarius.ViGEm.Client.Targets.DualShock4.DualShock4Helper"
	controllerClass := "Nefarius.ViGEm.Client.Targets.DualShock4Controller"
}

; Xb360-specific settings
class ViGEmXb360 extends ViGEmTarget {
	helperClass := "Nefarius.ViGEm.Client.Targets.Xbox360.Xb360Helper"
	controllerClass := "Nefarius.ViGEm.Client.Targets.Xbox360Controller"
}