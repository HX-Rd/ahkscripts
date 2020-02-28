; Autohotkey script "Toggle Mouse sensitivity"
;=================================================================================
SuperSlowMouseSpeed := 1
SlowMouseSpeed      := 5
FastMouseSpeed      := 10
SuperFastMouseSpeed := 20
UserMouseSpeed      := 0    ; Speed sensed before slow down
MouseThreshold1     := 6
MouseThreshold2     := 10
MouseEnhance        := 1

SPI_GETMOUSESPEED   := 0x70
SPI_SETMOUSESPEED   := 0x71
SPI_SETMOUSE        := 0x04 

NormalMouseSpeedState       := true  
SlowMouseSpeedState         := false
SuperSlowMouseSpeedState    := false 
FastMouseSpeedState         := false
SuperFastMouseSpeedState    := false

;=================================================================================
F21::
    toggleSuperFastMouseSpeed()
return
F22::
    toggleFastMouseSpeed()
return
F23::
    toggleSlowMouseSpeed()
return
F24::
    toggleSuperSlowMouseSpeed()
return
;=================================================================================

toggleSuperSlowMouseSpeed() {
    global
    ; SET LOW SPEED
    if( !SuperSlowMouseSpeedState )
    {
        ; SENSE BEFORE
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,prevSpeed, UInt,0)

        ; Temporarily reduces the mouse cursor's speed.
        ; Retrieve the current speed so that it can be restored later
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,UserMouseSpeed, UInt,0)
        ; Slow down mouse speed
        DllCall("SystemParametersInfo", UInt,SPI_SETMOUSESPEED, UInt,0, UInt,SuperSlowMouseSpeed, UInt,0)

        ; SENSE AFTER
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,currentSpeed, UInt,0)

        ; REMEMBER CURRENT STATE
        SuperSlowMouseSpeedState    := true
        SlowMouseSpeedState         := false
        NormalMouseSpeedState       := false
        FastMouseSpeedState         := false
        SuperFastMouseSpeedState    := false
    }
}

toggleSlowMouseSpeed() {
    global
    ; SET LOW SPEED
    if( !SlowMouseSpeedState )
    {
        ; SENSE BEFORE
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,prevSpeed, UInt,0)

        ; Temporarily reduces the mouse cursor's speed.
        ; Retrieve the current speed so that it can be restored later
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,UserMouseSpeed, UInt,0)
        ; Slow down mouse speed
        DllCall("SystemParametersInfo", UInt,SPI_SETMOUSESPEED, UInt,0, UInt,SlowMouseSpeed, UInt,0)

        ; SENSE AFTER
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,currentSpeed, UInt,0)

        ; REMEMBER CURRENT STATE
        SuperSlowMouseSpeedState    := false
        SlowMouseSpeedState         := true
        NormalMouseSpeedState       := false
        FastMouseSpeedState         := false
        SuperFastMouseSpeedState    := false
    }
}

toggleFastMouseSpeed() {
    global
    ; SET LOW SPEED
    if( !FastMouseSpeedState )
    {
        ; SENSE BEFORE
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,prevSpeed, UInt,0)

        ; Temporarily reduces the mouse cursor's speed.
        ; Retrieve the current speed so that it can be restored later
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,UserMouseSpeed, UInt,0)
        ; Slow down mouse speed
        DllCall("SystemParametersInfo", UInt,SPI_SETMOUSESPEED, UInt,0, UInt,FastMouseSpeed, UInt,0)

        ; SENSE AFTER
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,currentSpeed, UInt,0)

        ; REMEMBER CURRENT STATE
        SuperSlowMouseSpeedState    := false
        SlowMouseSpeedState         := false
        NormalMouseSpeedState       := false
        FastMouseSpeedState         := true
        SuperFastMouseSpeedState    := false
    }
}

toggleSuperFastMouseSpeed() {
    global
    ; SET LOW SPEED
    if( !SuperFastMouseSpeedState )
    {
        ; SENSE BEFORE
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,prevSpeed, UInt,0)

        ; Temporarily reduces the mouse cursor's speed.
        ; Retrieve the current speed so that it can be restored later
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,UserMouseSpeed, UInt,0)
        ; Slow down mouse speed
        DllCall("SystemParametersInfo", UInt,SPI_SETMOUSESPEED, UInt,0, UInt,SuperFastMouseSpeed, UInt,0)

        ; SENSE AFTER
        DllCall("SystemParametersInfo", UInt,SPI_GETMOUSESPEED, UInt,0, UIntP,currentSpeed, UInt,0)

        ; REMEMBER CURRENT STATE
        SuperSlowMouseSpeedState    := false
        SlowMouseSpeedState         := false
        NormalMouseSpeedState       := false
        FastMouseSpeedState         := false
        SuperFastMouseSpeedState    := true
    }
}




;=================================================================================
InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4) {
    ; Copy each byte in the integer into the structure as raw binary data. 
    Loop %pSize%
    DllCall("RtlFillMemory", "UInt",&pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF) 
}
;=================================================================================
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

;=================================================================================