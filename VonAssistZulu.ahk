SetTitleMatchMode 3
TraySetIcon(A_ScriptDir "\ExampleLogo.ico")

MyGui := Gui(,"Example Assistant")
MyGui.Opt("AlwaysOnTop")
MyGui.SetFont("s12")
MyGui.Add("Text","X90 Y20", "When to leave?")
MyGui.SetFont("s10 w700")
MyGui.Add("Button", "x60 y50 w80 h25", "Now").OnEvent("Click", Example_Logout)
MyGui.Add("Button", "x160 y50 w80 h25", "Later").OnEvent("Click", Later)
MyGui.Add("Button", "x110 y80 w80 h25", "Break").OnEvent("Click", On_Break)
MyGui.Show("w300 h120")

Later(*) {

Alpha:

MyGui.Destroy

If !WinExist("Example ContactPad")
{
	MsgBox "Example's window is already closed!", "Error", "4112"
	MsgBox "Double Check that you're logged out!", "Reminder", "4144"
	ExitApp
}

foxtrot := InputBox("`tEnter time in minutes:", "Timer", "w250 h100")

If foxtrot.result = "Cancel"
{
	ExitApp
}

If !IsNumber(foxtrot.value)
{
	MsgBox "You must enter numbers only!", "Error", "4112"
	MsgBox "Try again", "Prompt", "4160"
	GoTo Alpha
}


Echo := MsgBox("Log out & Shutdown in " foxtrot.value " minutes`n`nClick OK to Continue or Cancel to Abort Timer.", "Info", "4161")

If (Echo = "OK")
{
	Sleep foxtrot.value*60*1000
	Example_Logout
}
else if (Echo = "Cancel")
{
	ExitApp
}

}

On_Break(*) {

Bravo:

MyGui.Destroy
If !WinExist("Example ContactPad")
{
	MsgBox "Example's window is already closed!", "Error", "4112"
	MsgBox "Launch Example from Chrome's extensions!", "Reminder", "4144"
	ExitApp
}

MsgBox "You must keep Example's window open for this to work properly!", "Important", "4161"

tango := InputBox("`tEnter time in minutes:", "Timer", "w250 h100")

If tango.result = "Cancel"
{
	ExitApp
}

If !IsNumber(tango.value)
{
	MsgBox "You must enter numbers only!", "Error", "4112"
	MsgBox "Try again", "Prompt", "4160"
	GoTo Bravo
}

romeo := MsgBox("Break for " tango.value " minutes`n`nClick OK to Continue or Cancel to Abort Timer.", "Info", "4161")

If (romeo = "OK")
{
	Sleep tango.value*60*1000
	WinSetAlwaysOnTop 1, "Example ContactPad"
	WinActivate "Example ContactPad"
	WinMove 0, 0, , , "Example ContactPad"
	WinMaximize "Example ContactPad"
	CoordMode "Mouse", "Client"	
	Click 102, 111 ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @here <<<<<<<<<<<<<<<<<<<<<<<<<
	Send "{Down 14}"
	Send "{Enter}"
	TrayTip , "Break is over", "2"
	Loop 10
	{ 
	SoundBeep 850, 500 
	}
}
else if (romeo = "Cancel")
{	
	ExitApp
}

}

Example_Logout(*) {

MyGui.Destroy

If WinExist("Example ContactPad")
{
	WinSetAlwaysOnTop
	WinActivate
	WinMove 0, 0, , , "Example ContactPad"
	WinMaximize
	CoordMode "Mouse", "Client"
	Click 102, 111  ; <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @here <<<<<<<<<<<<<<<<<<<<<<<<<
	Send "{End}"
	Send "{Enter}"
	Sleep 4000
	MsgBox "All Systems Offline", "Shutdown", "4144 T3"
	Shutdown 13
}
else
{
	MsgBox "Example's window is already closed!", "Error", "4112"
	MsgBox "Double Check that you're logged out!", "Reminder", "4144"
	ExitApp
}

}

#SingleInstance
