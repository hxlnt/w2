
                                    ;;;;;; w2 // hxlnt 2019 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                          


    .include "game/header.asm"      ;;;;;; Header
    .rsset $0000
    .include "lib/variables.asm"
    .include "game/variables.asm" 
    .include "lib/constants.asm"
    .include "game/constants.asm"

    .rsset $6000
    .include "game/wram.asm"

    .bank 0
    .org $8000            
    .include "lib/console_init.asm" 
    .include "game/init.asm"

    JSR TurnScreenOff
    
    LDX #HIGH(attract_pal)
    LDY #PALETTE_BG
    JSR LoadPalette_All

    LDX #HIGH(attract_bg)
    LDY #NMTBL_TOP_LEFT
    JSR LoadBackground_All

    LDX #HIGH(attract_attr)
    LDY #NMTBL_TOP_LEFT
    JSR LoadAttr_All

    jsr DrawResetCount
    JSR TurnScreenOn                        

GameLoop:                               ;;;;;; Main game loop
;    JSR ReadController1
;    LDA buttons1read
;    CMP #GAMEPAD_B
;    BNE GameLoop
;    LDA scroll
;    CLC
;    ADC #$01
;    STA scroll
;    AND #%00001111
;    STA scroll
    JMP GameLoop

    .include "lib/counters.asm"

    .bank 1                             ;;;;;; Audio
    .org $A000
    ;.org MUSIC_LOAD
    ;.incbin "game/data/music.nsf"

    .bank 2                             ;;;;;; Graphics
    .org $C000
    .include "game/graphics.asm"
    .include "lib/graphics.asm"
    .include "lib/io.asm"               ;;;;;; I/O
    .include "game/subroutines.asm"

NMI:                                    ;;;;;; NMI
    PHA
    TXA
    PHA
    TYA
    PHA
    JSR Counter
NMIPatch:
    LDX #HIGH(end_txt)
    LDY #LOW(end_txt)
    JSR LoadBackground_Patch
NMIDone:  
    JSR Scroll
    ;JSR MUSIC_PLAY                              
    PLA
    TAY 
    PLA 
    TAX
    PLA
    RTI

    .bank 3                             ;;;;;; Vectors
    .org $E000
    .org $FFFA
    .dw NMI
    .dw Reset
    .dw 0

    .bank 4                             ;;;;;; CHR-ROM
    .org $0000
    .incbin "game/data/graphics.chr"