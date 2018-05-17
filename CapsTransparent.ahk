#SingleInstance, Force
#NoEnv

OnExit Exit
Menu, Tray, Tip, CapsTransparent
Return

CapsLock & a::
CapsLock & s::
WinGetClass, Class, A
If Class = Progman
      Return
If Needle%Win_Id% = 
{
	WinGet, Trans, Transparent, A
	IfEqual, Trans,, SetEnv, Trans, 255
	List = %List%%Win_Id%,%Trans% 
	Needle%Win_Id% = %Trans%
}
IfEqual, A_ThisHotkey, CapsLock & s, EnvAdd, Needle%Win_Id%, 15
Else Needle%Win_Id% -= 15
IfGreater, Needle%Win_Id%, 255, SetEnv, Needle%Win_Id%, 255
IfLess, Needle%Win_Id%, 30, SetEnv, Needle%Win_Id%, 30
Winset, Transparent,% Needle%Win_Id%, A
Return

Exit:
Loop, Parse, List, `,
If (A_Index & 1)           ; Win_ID's are in odd positions
         Id = %A_LoopField%
      Else
         Winset Transparent, %A_LoopField%, ahk_id %Id% 
ExitApp