global at
global iat
global ids

__Script_Init__() {
	static init := __Script_Init__()
	at = 220
      iat = 150
      ids := Object()
      Gui +LastFound 
      hWnd := WinExist()
      DllCall( "RegisterShellHookWindow", UInt,Hwnd )
      MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
      OnMessage( MsgNum, "ShellMessage" )
}

HasValue(obj, elm) {
    if(!isObject(obj))
        return -1
    if(obj.Length()==0)
        return -1
    for k,v in obj
        if(v==elm)
            return k
    return -1
}

RemoveAlloccurrencesFromArray(arr, elm) {
      idIndex := HasValue(arr, elm)
      while (idIndex != -1) {
            arr.Remove(idIndex)
            idIndex := HasValue(arr, elm)
      }
}

InActiveFocus() {
      WinGet, activeId, ID, A
      loop % ids.MaxIndex() {
            nextId := % ids[A_Index]
            ; Should not happen but keep it in there for completeness
            if(nextId != activeId) {
                  Winset, Transparent, %iat%, ahk_id %nextId%
            }
      }
}

ShellMessage( wParam,lParam ) {
      RemoveAlloccurrencesFromArray(ids, lParam)
      InActiveFocus()
      ids.Insert(lParam)
      Winset, Transparent, %at%, ahk_id %lParam%
}

CapsLock & q::
CapsLock & w::
      WinGet, activeId, ID, A
      RemoveAlloccurrencesFromArray(ids, activeId)
      IfEqual, A_ThisHotkey, CapsLock & w, EnvAdd, iat, 15
      else iat -= 15
      IfGreater, iat, 255, SetEnv, iat, 255
      IfLess, iat, 30, SetEnv, iat, 30
      InActiveFocus()
      ids.Insert(activeId)
return

CapsLock & a::
CapsLock & s::
      IfEqual, A_ThisHotkey, CapsLock & s, EnvAdd, at, 15
      else at -= 15
      IfGreater, at, 255, SetEnv, at, 255
      IfLess, at, 30, SetEnv, at, 30
      Winset, Transparent, %at%, A
return
