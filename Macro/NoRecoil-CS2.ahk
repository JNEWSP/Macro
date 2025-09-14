#NoEnv
#SingleInstance Force
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%

; Configurações iniciais
global modifier := 1
global smoothness := 0.7
global sens := 1.82
global zoomsens := 1
global key_shoot := "LButton"
global key_AK := "Numpad4"
global key_M4A1 := "Numpad2"
global key_M4A4 := "Numpad1"
global key_Famas := "Numpad3"
global key_Galil := "Numpad5"
global key_UMP := "Numpad6"
global key_AUG := "Numpad8"
global key_SG := "Numpad7"
global key_off := "Numpad9"
global key_zoom := "LAlt"
global key_exit := "End"
global PauseKey := "xButton1"
global paused := false

; Inicialização
modifier := 2.52 / sens

; Loop principal
Loop {
    Sleep, 1

    ; Pausa/Resume
    if GetKeyState(PauseKey, "P") {
        paused := !paused
        Sleep, 200
    }

    ; Sair
    if GetKeyState(key_exit, "P") {
        Sleep, 2000
        ExitApp
    }

    ; Verifica se está pausado
    if (!paused) {
        ; Verifica qual arma está ativa
        ak := GetKeyState(key_AK, "P")
        m4a1 := GetKeyState(key_M4A1, "P")
        m4a4 := GetKeyState(key_M4A4, "P")
        famas := GetKeyState(key_Famas, "P")
        galil := GetKeyState(key_Galil, "P")
        ump := GetKeyState(key_UMP, "P")
        aug := GetKeyState(key_AUG, "P")
        sg := GetKeyState(key_SG, "P")
        
        ; Aplica o recoil se estiver atirando e com arma selecionada
        if (GetKeyState(key_shoot, "P")) {  ; CORREÇÃO AQUI - FALTAVA UM PARÊNTESE
            if (ak) {
                ; AK-47 Recoil Pattern
                DllCall("mouse_event", "UInt", 0x01, "UInt", -4 * modifier, "UInt", 7 * modifier)
                Sleep, 99
                DllCall("mouse_event", "UInt", 0x01, "UInt", 4 * modifier, "UInt", 19 * modifier)
                Sleep, 99
                ; Adicione os outros passos do padrão AK aqui...
                
            } else if (m4a1) {
                ; M4A1-S Recoil Pattern
                DllCall("mouse_event", "UInt", 0x01, "UInt", 1 * modifier, "UInt", 6 * modifier)
                Sleep, 88
                DllCall("mouse_event", "UInt", 0x01, "UInt", 0 * modifier, "UInt", 4 * modifier)
                Sleep, 88
                ; Adicione os outros passos do padrão M4A1 aqui...
                
            } else if (m4a4) {
                ; M4A4 Recoil Pattern
                DllCall("mouse_event", "UInt", 0x01, "UInt", 2 * modifier, "UInt", 7 * modifier)
                Sleep, 88
                DllCall("mouse_event", "UInt", 0x01, "UInt", 0 * modifier, "UInt", 9 * modifier)
                Sleep, 87
                ; Adicione os outros passos do padrão M4A4 aqui...
                
            } else if (famas) {
                ; FAMAS Recoil Pattern
                DllCall("mouse_event", "UInt", 0x01, "UInt", -4 * modifier, "UInt", 5 * modifier)
                Sleep, 88
                DllCall("mouse_event", "UInt", 0x01, "UInt", 1 * modifier, "UInt", 4 * modifier)
                Sleep, 88
                ; Adicione os outros passos do padrão FAMAS aqui...
                
            } else if (galil) {
                ; Galil Recoil Pattern
                DllCall("mouse_event", "UInt", 0x01, "UInt", 4 * modifier, "UInt", 4 * modifier)
                Sleep, 90
                DllCall("mouse_event", "UInt", 0x01, "UInt", -2 * modifier, "UInt", 5 * modifier)
                Sleep, 90
                ; Adicione os outros passos do padrão Galil aqui...
                
            } else if (ump) {
                ; UMP-45 Recoil Pattern
                DllCall("mouse_event", "UInt", 0x01, "UInt", -1 * modifier, "UInt", 6 * modifier)
                Sleep, 90
                DllCall("mouse_event", "UInt", 0x01, "UInt", -4 * modifier, "UInt", 8 * modifier)
                Sleep, 90
                ; Adicione os outros passos do padrão UMP aqui...
                
            } else if (aug) {
                ; AUG Recoil Pattern
                zom := GetKeyState(key_zoom, "P") ? (1.2 / zoomsens) : 1
                DllCall("mouse_event", "UInt", 0x01, "UInt", 5 * modifier * zom, "UInt", 6 * modifier * zom)
                Sleep, 89
                DllCall("mouse_event", "UInt", 0x01, "UInt", 0 * modifier * zom, "UInt", 13 * modifier * zom)
                Sleep, 89
                ; Adicione os outros passos do padrão AUG aqui...
                
            } else if (sg) {
                ; SG 553 Recoil Pattern
                zom := GetKeyState(key_zoom, "P") ? (1.2 / zoomsens) : 1
                DllCall("mouse_event", "UInt", 0x01, "UInt", -4 * modifier * zom, "UInt", 9 * modifier * zom)
                Sleep, 89
                DllCall("mouse_event", "UInt", 0x01, "UInt", -13 * modifier * zom, "UInt", 15 * modifier * zom)
                Sleep, 89
                ; Adicione os outros passos do padrão SG aqui...
            }
        }
    }
}

; Função para movimento suave do mouse (opcional)
SmoothMouseMove(x, y, smoothness) {
    steps := 2.6  
    stepSizeX := x / steps
    stepSizeY := y / steps
    sleepTime := 1

    Loop, % steps {
        x := x - stepSizeX
        y := y - stepSizeY
        DllCall("mouse_event", "UInt", 0x01, "UInt", x, "UInt", y)
        Sleep, sleepTime * smoothness
    }
}