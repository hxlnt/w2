
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  w2 // hxlnt 2019


    .include "game/header.asm"      ;  Import header.

    .rsset $0000
    .include "lib/variables.asm"    ;  Import library variables.
    .include "game/variables.asm"   ;  Import game variables.

    .rsset $6000
    .include "game/wram.asm"        ;  Import WRAM variables.


    .bank 0 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 0: PROGRAM CODE
    .org $8000 ;;;;;;;;;;;;;;;;;;;;;;  $8000 - $9FFF

    LDA #%00001110                  ;  Configure banks.
    STA bank_config                 ;

    .include "lib/console_init.asm" ;  Import and run initial 
    .include "game/init.asm"        ;    ization subroutines.

    JSR TurnScreenOff               ;  Turn screen off.
    
    LDX #HIGH(end_pal)          ;  Load attract_pal into
    LDY #LOW(end_pal)           ;    background palette.
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

    LDX gamestate                   ;  Use current gamestate
    LDA gameloop_table, x           ;    as index for game loop
    PHA                             ;    jump table.
    INX                             ;
    LDA gameloop_table, x           ;
    PHA                             ;            
    RTS                             ;
    JMP GameLoop                    ;  End game loop.

    .include "lib/counters.asm"     ;  Import counter and I/O
    .include "lib/io.asm"           ;    subroutines.
    .include "lib/lookup_tables.asm";  Import lookup tables.
    .include "game/subroutines.asm" ;  Import game subroutines.
    .include "game/gameengine.asm"  ;  Import gamestate list.

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

    LDX gamestate                   ;  Use current gamestate as
    LDA nmiloop_table, x            ;    as index for NMI loop
    PHA                             ;    jump table.
    INX                             ;
    LDA nmiloop_table, x            ;
    PHA                             ;
    RTS                             ;

NMIDone:
    JSR Scroll                      ;  Scroll background.

    PLA                             ;  Pop Y, X, and A off the
    TAY                             ;    stack.
    PLA                             ;
    TAX                             ;
    PLA                             ;
    RTI                             ;

    .include "lib/mmc1.asm"         ;  Include MMC1 subroutines.

    .org $FFFA                      ;  Set last three bytes as
    .dw NMI                         ;    NMI, Reset, and IRQ
    .dw Reset                       ;    vectors.
    .dw 0

    .bank 4 ;;;;;;;;;;;;;;;;;;;;;;;;;  BANK 4: CHR-ROM
    .org $0000 ;;;;;;;;;;;;;;;;;;;;;;  $0000 - $1FFF

    .incbin "game/data/graphics.chr";  Include graphics binary.