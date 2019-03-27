#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Modifier Key
; + Shift
; ^ Ctrl
; ! Alt
; # Win

!Left::Send {PgUp}
!Right::Send {PgDn}
^!Left::Send ^{PgUp}
^!Right::Send ^{PgDn}
Media_Stop::Send ^{Home}
Media_Play_Pause::Send ^{End}
Media_Prev::Send {Home}
Media_Next::Send {End}
