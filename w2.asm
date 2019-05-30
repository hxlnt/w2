
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  w2 // hxlnt 2019


    .include "game/header.asm"      ;  Import header

    .rsset $0000
    .include "lib/variables.asm"    ;  Import library variables
    .include "game/variables.asm"   ;  Import game variables
    .include "game/constants.asm"   ;  Import game constants

    .rsset $6000
    .include "game/wram.asm"        ;  Import WRAM variables 


    .bank 0 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 0: PROGRAM CODE
    .org $8000 ;;;;;;;;;;;;;;;;;;;;;;  $8000 - $9FFF

    .include "lib/console_init.asm" ;  Import initialization
    .include "game/init.asm"        ;    subroutines

    JSR TurnScreenOff               ;  Turn screen off
    
    LDX #HIGH(attract_pal)          ;  Load attract_pal palette
    LDY #LOW(attract_pal)           ;  
    JSR LoadPalette_All             ;

    LDX #HIGH(attract_bg)           ;  Load attract_bg in top-
    LDY #NMTBL_TOP_LEFT             ;    left nametable
    JSR LoadBackground_All          ;    

    LDX #HIGH(attract_attr)         ;  Load attract_attr in top-
    LDY #NMTBL_TOP_LEFT             ;    left nametable
    JSR LoadAttr_All                ;

    JSR DrawResetCount              ;  Draw reset counter

    JSR TurnScreenOn                ;  Turn screen on

GameLoop:                           ;  Start game loop

    LDY framecounter                ;  Set scroll_x with
    LDA sine, y                     ;    incremental values from
    STA scroll_x                    ;    sine lookup table

    JMP GameLoop                    ;  End game loop

    .include "lib/io.asm"           ;  Import I/O subroutines
    .include "lib/counters.asm"     ;  Import counter and MMC1
    .include "lib/mmc1.asm"         ;    subroutines
    .include "lib/lookup_tables.asm";  Import lookup tables
    .include "game/subroutines.asm" ;  Import game subroutines


    .bank 1 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 1: AUDIO                         
    .org $A000 ;;;;;;;;;;;;;;;;;;;;;;  $A000 - $BFFF


    .bank 2 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 2: GRAPHICS
    .org $C000 ;;;;;;;;;;;;;;;;;;;;;;  $C000 - $DFFF

    .include "game/graphics.asm"    ;  Import graphics
    .include "lib/graphics.asm"     ;  Import graphics and 
    .include "lib/scroll.asm"       ;    scroll subroutines


    .bank 3 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 3: NMI AND VECTORS
    .org $E000 ;;;;;;;;;;;;;;;;;;;;;;  $E000 - $FFFF

NMI:                                ;  Start NMI

    PHA                             ;  Push A, X, and Y to the
    TXA                             ;    stack
    PHA
    TYA
    PHA

    JSR Counter                     ;  Increment counters

    LDX #HIGH(end_txt)              ;  Write end_txt to the
    LDY #LOW(end_txt)               ;    background
    JSR LoadBackground_Patch        ;

    JSR Scroll                      ;  Scroll background

    PLA                             ;  Pop Y, X, and A off the
    TAY                             ;    stack
    PLA 
    TAX
    PLA
    RTI

    .org $FFFA                      ;  Set last three bytes as
    .dw NMI                         ;    NMI, Reset, and IRQ
    .dw Reset                       ;    vectors
    .dw 0

    .bank 4 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 4: CHR-ROM
    .org $0000 ;;;;;;;;;;;;;;;;;;;;;;  $0000 - $1FFF

    .incbin "game/data/graphics.chr";  Include graphics binary