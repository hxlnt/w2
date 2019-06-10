
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  w2 // hxlnt 2019


    .include "game/header.asm"      ;  Import header.

    .rsset $0000
    .include "lib/variables.asm"    ;  Import library variables.
    .include "game/variables.asm"   ;  Import game variables.
    .include "game/gamestates.asm"  ;  Import gamestate list.

    .rsset $6000
    .include "game/wram.asm"        ;  Import WRAM variables.


    .bank 0 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 0: PROGRAM CODE
    .org $8000 ;;;;;;;;;;;;;;;;;;;;;;  $8000 - $9FFF

    LDA #%00001110                  ;  Configure banks.
    STA bank_config                 ;

    .include "lib/console_init.asm" ;  Import and run initial 
    .include "game/init.asm"        ;    ization subroutines.

    JSR TurnScreenOff               ;  Turn screen off.
    
    LDX #HIGH(attract_pal)          ;  Load attract_pal into
    LDY #LOW(attract_pal)           ;    background palette.
    LDA #PALETTE_BG                 ;
    JSR LoadPalette                 ;

    LDX #HIGH(attract_pal)          ;  Load attract_pal into
    LDY #LOW(attract_pal)           ;    sprite palette.
    LDA #PALETTE_SPR                ;
    JSR LoadPalette                 ;

    LDX #HIGH(attract_bg)           ;  Load attract_bg in top-
    LDY #NMTBL_TOP_LEFT             ;    left nametable.
    JSR LoadBackground_All          ;    

    LDX #HIGH(attract_attr)         ;  Load attract_attr in top-
    LDY #NMTBL_TOP_LEFT             ;    left nametable.
    JSR LoadAttr_All                ;

    LDX #HIGH(attract_spr)          ;  Load attract_spr.
    LDY #LOW(attract_spr)           ;
    LDA #ATTRACT_SPR_LEN            ;
    JSR LoadSpr                     ;

    JSR DrawResetCount              ;  Draw reset counter.

    JSR TurnScreenOn                ;  Turn screen on.

GameLoop:                           ;  Start game loop.

    LDY framecounter                ;  Set scroll_x with
    LDA sine, y                     ;    incremental values from
    STA scroll_x                    ;    sine lookup table.

    JMP GameLoop                    ;  End game loop.

    .include "lib/counters.asm"     ;  Import counter and I/O
    .include "lib/io.asm"           ;    subroutines.
    .include "lib/lookup_tables.asm";  Import lookup tables.
    .include "game/subroutines.asm" ;  Import game subroutines.

    .bank 1 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 1: AUDIO                         
    .org $A000 ;;;;;;;;;;;;;;;;;;;;;;  $A000 - $BFFF


    .bank 2 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 2: GRAPHICS
    .org $C000 ;;;;;;;;;;;;;;;;;;;;;;  $C000 - $DFFF

    .include "game/graphics.asm"    ;  Import graphic tables.
    .include "lib/graphics.asm"     ;  Import graphics and 
    .include "lib/scroll.asm"       ;    scroll subroutines.


    .bank 3 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 3: NMI AND VECTORS
    .org $E000 ;;;;;;;;;;;;;;;;;;;;;;  $E000 - $FFFF

NMI:                                ;  Start NMI.

    PHA                             ;  Push A, X, and Y to the
    TXA                             ;    stack.
    PHA                             ;
    TYA                             ;
    PHA                             ;

    JSR Counter                     ;  Increment counters.

    LDA gamestate
    BNE NMITestEnd
    JSR $E040
    JMP NMITestDone
NMITestEnd:
    JSR $E060
NMITestDone:

    JSR SpriteDMA                   ;  Transfer sprites.

    JMP NMIDone                     ;  Jump to NMI cleanup.

    .org $E040
NMIAttract:
    LDA framecounter
    CMP #$2B
    BEQ NMIAttractPalSwap
    LDA #$01
    STA gamestate
    RTS
NMIAttractPalSwap:
    LDX #HIGH(attract_pal)          ;  Load attract_pal into
    LDY #LOW(attract_pal)           ;    BG palette.
    LDA #PALETTE_BG                 ;
    JSR LoadPalette                 ;
    RTS


    .org $E0C0
NMIEnd:
    LDA framecounter
    CMP #$2B
    BEQ NMIEndPalSwap
    LDA #$00
    STA gamestate
    RTS
NMIEndPalSwap:
    LDX #HIGH(end_pal)              ;  Load attract_pal into
    LDY #LOW(end_pal)               ;    BG palette.
    LDA #PALETTE_BG                 ;
    JSR LoadPalette                 ;
    RTS

    .org $E140
NMIDone:
    JSR Scroll                      ;  Scroll background.

    PLA                             ;  Pop Y, X, and A off the
    TAY                             ;    stack.
    PLA                             ;
    TAX                             ;
    PLA                             ;
    RTI                             ;

    .include "lib/mmc1.asm"         ;  Include MMC1 subroutines.
    
gameloop_table:
    .dw $E040
    .dw $E0C0

    .org $FFFA                      ;  Set last three bytes as
    .dw NMI                         ;    NMI, Reset, and IRQ
    .dw Reset                       ;    vectors.
    .dw 0

    .bank 4 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 4: CHR-ROM
    .org $0000 ;;;;;;;;;;;;;;;;;;;;;;  $0000 - $1FFF

    .incbin "game/data/graphics.chr";  Include graphics binary.