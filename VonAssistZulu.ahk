MyGui := Gui(,"Example Logout")
MyGui.Opt("AlwaysOnTop")
MyGui.SetFont("s12")
MyGui.Add("Text","X80 Y20", "Leave Now or Later?")
MyGui.SetFont("s10 w700")
MyGui.Add("Button", "x70 y50 w80 h25", "Now").OnEvent("Click", Vonage_Logout)
MyGui.Add("Button", "x170 y50 w80 h25", "Later").OnEvent("Click", Timer)
MyGui.Show("w300 h120")


Timer(*) {

Label101:
MyGui.Destroy

If !WinExist("Vonage ContactPad")
{
MsgBox "Example's window is already closed!", "Error", "4112"
MsgBox "Double-Check that you're logget out!", "Reminder", "4144"
ExitApp
}

phd := InputBox("`tEnter time in minutes:", "Timer", "w250 h100")

If phd.result = "Cancel"
{
ExitApp
}

If !IsNumber(phd.value)
{
MsgBox "You must enter integer numbers only!", "Error", "4112"
MsgBox "Try again", "Prompt", "4160"
GoTo Label101
}


Decision := MsgBox("Log out & Shutdown in " phd.value " minutes`n`nClick OK to Continue or Cancel to Abort Timer.", "Info", "4161")

If (Decision = "OK")
{
	Sleep phd.value*60*1000
	Vonage_Logout
}
else if (Decision = "Cancel")
{
	ExitApp
}

}

Vonage_Logout(*) {

MyGui.Destroy

If WinExist("Example ContactPad")
{
	WinSetAlwaysOnTop
	WinActivate
	WinMove 0, 0, , , "Vonage ContactPad"
}
else
{
MsgBox "Example's window is already closed!", "Error", "4112"
MsgBox "Double Check that you're logget out!", "Reminder", "4144"
ExitApp
}

CoordMode "Mouse", "Client"

Click 102, 111
MouseMove 65, 481
Send "{End}"
Click

Sleep 4000
MsgBox "Systems are going off in 3''", "Shutdown", "4144 T3"
Shutdown 13

}
#SingleInstance

