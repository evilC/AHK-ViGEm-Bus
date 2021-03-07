#include %A_LineFile%\..\CLR.ahk

; Static class, holds ViGEm Client instance
class ViGEmWrapper {
	static asm := 0
	static client := 0
	
	Init(){
		if (this.client == 0){
			this.asm := CLR_LoadLibrary(A_LineFile "\..\ViGEmWrapper.dll")
		}
	}
	
	CreateInstance(cls){
		return this.asm.CreateInstance(cls)
	}

}

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
	}
	
	SubmitReport(){
		this.Instance.SubmitReport()
	}
	
	SubscribeFeedback(callback){
		this.Instance.SubscribeFeedback(callback)
	}
}

; DS4 (DualShock 4 for Playstation 4)
class ViGEmDS4 extends ViGEmTarget {
	helperClass := "ViGEmWrapper.Ds4"
	__New(){
		;~ static buttons := {Square: 16, Cross: 32, Circle: 64, Triangle: 128, L1: 256, R1: 512, L2: 1024, R2: 2048
			;~ , Share: 4096, Options: 8192, LS: 16384, RS: 32768 }
		static buttons := {RS: 0, LS: 1, Options: 2, Share: 3, R2: 4, L2: 5, R1: 6, L1: 7, Triangle: 8, Circle: 9, Cross: 10, Square: 11, Ps: 12, TouchPad: 13 }
		;~ static specialButtons := {Ps: 1, TouchPad: 2}
		;~ static axes := {LX: 2, LY: 3, RX: 4, RY: 5, LT: 0, RT: 1}
		static axes := {LX: 0, LY: 1, RX: 2, RY: 3}
		static sliders = {LT: 0, RT: 1}
		
		this.Buttons := {}
		for name, id in buttons {
			this.Buttons[name] := new this._ButtonHelper(this, id)
		}
		;~ for name, id in specialButtons {
			;~ this.Buttons[name] := new this._SpecialButtonHelper(this, id)
		;~ }
		
		this.Axes := {}
		for name, id in axes {
			this.Axes[name] := new this._AxisHelper(this, id)
		}
		
		for name, id in sliders {
			this.Axes[name] := new this._SliderHelper(this, id)
		}
		
		this.Dpad := new this._DpadHelper(this)
		base.__New()
	}
	
	class _ButtonHelper {
		__New(parent, id){
			this._Parent := parent
			this._Id := id
		}
		
		SetState(state){
			this._Parent.Instance.SetButtonState(this._Id, state)
			this._Parent.Instance.SubmitReport()
			return this._Parent
		}
	}
	
	;~ class _SpecialButtonHelper {
		;~ __New(parent, id){
			;~ this._Parent := parent
			;~ this._Id := id
		;~ }
		
		;~ SetState(state){
			;~ this._Parent.Instance.SetSpecialButtonState(this._Id, state)
			;~ this._Parent.Instance.SubmitReport()
			;~ return this._Parent
		;~ }
	;~ }
	
	class _AxisHelper {
		__New(parent, id){
			this._Parent := parent
			this._Id := id
		}
		
		SetState(state){
			this._Parent.Instance.SetAxisState(this._Id, this.ConvertAxis(state))
			this._Parent.Instance.SubmitReport()
			return this._Parent
		}
		
		ConvertAxis(state){
			value := round((state * 655.36) - 32768)
			if (value == 32768)
				return 32767
			return value
		}
	}

	class _SliderHelper {
		__New(parent, id){
			this._Parent := parent
			this._id := id
		}
		
		SetState(state){
			this._Parent.Instance.SetSliderState(this._Id, this.ConvertAxis(state))
			this._Parent.Instance.SubmitReport()
		}
		
		ConvertAxis(state){
			value := round(state * 2.55)
			return value
		}	
	}
	
	class _DpadHelper {
		__New(parent){
			this._Parent := parent
			this._Id := id
		}
		
		SetState(state){
			static dPadDirections := {Up: 0, UpRight: 1, Right: 2, DownRight: 3, Down: 4, DownLeft: 5, Left: 6, UpLeft: 7, None: 8}
			this._Parent.Instance.SetDpadState(dPadDirections[state])
			this._Parent.Instance.SubmitReport()
			return this._Parent
		}
	}
}

; Xb360
class ViGEmXb360 extends ViGEmTarget {
	helperClass := "ViGEmWrapper.Xb360"
	__New(){
		;~ static buttons := {A: 4096, B: 8192, X: 16384, Y: 32768, LB: 256, RB: 512, LS: 64, RS: 128, Back: 32, Start: 16, Xbox: 1024}
		static buttons := {Start: 4, Back: 5, LS: 6, RS: 7, LB: 8, RB: 9, Xbox: 10, A: 11, B: 12, X: 13, Y: 14}
		;~ static axes := {LX: 2, LY: 3, RX: 4, RY: 5, LT: 0, RT: 1}
		static axes := {LX: 0, LY: 1, RX: 2, RY: 3}
		static sliders := {LT: 0, RT: 1}
		
		this.Buttons := {}
		for name, id in buttons {
			this.Buttons[name] := new this._ButtonHelper(this, id)
		}
		
		this.Axes := {}
		for name, id in axes {
			this.Axes[name] := new this._AxisHelper(this, id)
		}
		
		for name, id in sliders {
			this.Axes[name] := new this._SliderHelper(this, id)
		}
		
		this.Dpad := new this._DpadHelper(this)
		
		base.__New()
	}
	
	class _ButtonHelper {
		__New(parent, id){
			this._Parent := parent
			this._Id := id
		}
		
		SetState(state){
			this._Parent.Instance.SetButtonState(this._Id, state)
			this._Parent.Instance.SubmitReport()
			return this._Parent
		}
	}
	
	class _AxisHelper {
		__New(parent, id){
			this._Parent := parent
			this._id := id
		}
		
		SetState(state){
			this._Parent.Instance.SetAxisState(this._Id, this.ConvertAxis(state))
			this._Parent.Instance.SubmitReport()
		}
		
		ConvertAxis(state){
			value := round((state * 655.36) - 32768)
			if (value == 32768)
				return 32767
			return value
		}
	}
	
	class _SliderHelper {
		__New(parent, id){
			this._Parent := parent
			this._id := id
		}
		
		SetState(state){
			this._Parent.Instance.SetSliderState(this._Id, this.ConvertAxis(state))
			this._Parent.Instance.SubmitReport()
		}
		
		ConvertAxis(state){
			value := round(state * 2.55)
			return value
		}	
	}
	
	class _DpadHelper {
		_DpadStates := {1:0, 8:0, 2:0, 4:0} ; Up, Right, Down, Left
		__New(parent){
			this._Parent := parent
		}
		
		SetState(state){
			static dpadDirections := { None: {0:0, 3:0, 1:0, 2:0}
				, Up: {0:1, 3:0, 1:0, 2:0}
				, UpRight: {0:1, 3:1, 1:0, 2:0}
				, Right: {0:0, 3:1, 1:0, 2:0}
				, DownRight: {0:0, 3:1, 1:1, 2:0}
				, Down: {0:0, 3:0, 1:1, 2:0}
				, DownLeft: {0:0, 3:0, 1:1, 2:1}
				, Left: {0:0, 3:0, 1:0, 2:1}
				, UpLeft: {0:1, 3:0, 1:0, 2:1}}
			newStates := dpadDirections[state]
			for id, newState in newStates {
				oldState := this._DpadStates[id]
				if (oldState != newState){
					this._DpadStates[id] := newState
					this._Parent.Instance.SetButtonState(id, newState)
				}
				this._Parent.SubmitReport()
			}
		}
	}
}