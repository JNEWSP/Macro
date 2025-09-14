#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

Run, lib\lib.ahk

; GUI Configuration with Background
Gui, Color, 6c788e  ; Background color fallback
Gui, Margin, 10, 10

; Add background image from icon folder
if FileExist("icon\img.png") {
    Gui, Add, Picture, x0 y0 w489 h417 BackgroundTrans, icon\img.png
} else {
    ; Solid color fallback if image missing
    Gui, Add, Text, x0 y0 w489 h417 Background6c788e,
}

; Título Principal
Gui, Font, S16 cFFFFFF Bold, Comic Sans MS
Gui, Add, Text, x2 y5 w480 h30 +Center BackgroundTrans, SEGURA MIRA NEABAW
Gui, Add, Progress, x50 y35 w380 h2 cFFFFFF BackgroundTrans  ; Linha decorativa

; Tab Group
Gui, Font, S8 cFFFFFF Bold, Comic Sans MS
Gui, Add, Tab, x2 y45 w480 h370 BackgroundTrans, Atalhos do Teclado

; Weapon Hotkeys - Organized in 3 rows
; Row 1
Gui, Add, Text, x32 y75 w110 h20 +Center BackgroundTrans, M4A4
Gui, Add, Hotkey, x12 y95 w90 h30 vM4A4 BackgroundF5F5F5,

Gui, Add, Text, x212 y75 w110 h20 +Center BackgroundTrans, M4A1
Gui, Add, Hotkey, x192 y95 w90 h30 vM4A1 BackgroundF5F5F5,

Gui, Add, Text, x392 y75 w110 h20 +Center BackgroundTrans, Famas
Gui, Add, Hotkey, x372 y95 w90 h30 vFamas BackgroundF5F5F5,

; Row 2
Gui, Add, Text, x32 y145 w110 h20 +Center BackgroundTrans, AUG
Gui, Add, Hotkey, x12 y165 w90 h30 vAUG BackgroundF5F5F5,

Gui, Add, Text, x212 y145 w110 h20 +Center BackgroundTrans, AK
Gui, Add, Hotkey, x192 y165 w90 h30 vAK BackgroundF5F5F5,

Gui, Add, Text, x392 y145 w110 h20 +Center BackgroundTrans, Galil
Gui, Add, Hotkey, x372 y165 w90 h30 vGalil BackgroundF5F5F5,

; Row 3
Gui, Add, Text, x32 y215 w110 h20 +Center BackgroundTrans, SG
Gui, Add, Hotkey, x12 y235 w90 h30 vSG BackgroundF5F5F5,

Gui, Add, Text, x212 y215 w110 h20 +Center BackgroundTrans, UMP
Gui, Add, Hotkey, x192 y235 w90 h30 vUMP BackgroundF5F5F5,

Gui, Add, Text, x392 y215 w110 h20 +Center BackgroundTrans, Desligar
Gui, Add, Hotkey, x372 y235 w90 h30 voff BackgroundF5F5F5,

; Control Groups
Gui, Add, Text, x32 y285 w110 h20 +Center BackgroundTrans, Mira
Gui, Add, Edit, x12 y305 w90 h30 vzoomsenss BackgroundF5F5F5 c000000,

Gui, Add, Text, x212 y285 w110 h20 +Center BackgroundTrans, Sensibilidade
Gui, Add, Edit, x192 y305 w90 h30 vsenss BackgroundF5F5F5 c000000,

Gui, Add, Text, x392 y285 w110 h20 +Center BackgroundTrans, Zoom
Gui, Add, Hotkey, x372 y305 w90 h30 vzoom BackgroundF5F5F5,

; Info and Buttons
Gui, Font, S10 cFF0000 Bold, Comic Sans MS
Gui, Add, Text, x42 y345 w390 h25 +Center BackgroundTrans, IMPORTANTE: Configure sua sensibilidade!

Gui, Font, S9 cFFFFFF, Comic Sans MS
Gui, Add, Text, x42 y370 w390 h20 +Center BackgroundTrans, Você pode alterar as teclas Neabaw

Gui, Font, S9 cFFFFFF Bold, Comic Sans MS
Gui, Add, Button, x182 y390 w110 h30 gGenerateConfig, Salvar
Gui, Add, Text, x422 y25 w40 h20 BackgroundTrans, Jao

; Load saved settings
IniFile := "config\config.ini"
LoadSettings(IniFile)

Gui, Show, x599 y260 h417 w489, Macro Safadinho
Return

; Functions
GenerateConfig:
    Gui, Submit, NoHide
    SaveSettings(IniFile)
    MsgBox, Configurações salvas com sucesso!
Return

GuiClose:
    ExitApp

LoadSettings(file) {
    GuiControl,, senss, % GetIniValue(file, "Settings", "sens")
    GuiControl,, zoomsenss, % GetIniValue(file, "Settings", "zoomsens")
    GuiControl,, M4A4, % GetIniValue(file, "KeyBinds", "M4A4")
    GuiControl,, AUG, % GetIniValue(file, "KeyBinds", "AUG")
    GuiControl,, SG, % GetIniValue(file, "KeyBinds", "SG")
    GuiControl,, Galil, % GetIniValue(file, "KeyBinds", "Galil")
    GuiControl,, M4A1, % GetIniValue(file, "KeyBinds", "M4A1")
    GuiControl,, AK, % GetIniValue(file, "KeyBinds", "AK")
    GuiControl,, UMP, % GetIniValue(file, "KeyBinds", "UMP")
    GuiControl,, zoom, % GetIniValue(file, "KeyBinds", "Zoom")
    GuiControl,, Famas, % GetIniValue(file, "KeyBinds", "Famas")
    GuiControl,, off, % GetIniValue(file, "KeyBinds", "Off")
}

SaveSettings(file) {
    global senss, zoomsenss, M4A4, AUG, SG, Galil, M4A1, AK, UMP, zoom, Famas, off
    
    FileDelete, %file%
    FileAppend, [Settings]`nsens=%senss%`nzoomsens=%zoomsenss%`n, %file%
    FileAppend, [KeyBinds]`nM4A4=%M4A4%`nAUG=%AUG%`nSG=%SG%`nGalil=%Galil%`n, %file%
    FileAppend, M4A1=%M4A1%`nAK=%AK%`nUMP=%UMP%`nZoom=%zoom%`nFamas=%Famas%`nOff=%off%`n, %file%
}

GetIniValue(file, section, key, default := "") {
    IniRead, value, %file%, %section%, %key%, %default%
    return value
}

