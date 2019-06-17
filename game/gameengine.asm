
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Game engine


ATTRACT         = %00000000
ATTRACT_INIT    = %10000000
END             = %00000010
END_INIT        = %10000010

    .org $8302                      ;  Start game loop for
GameLoopAttract:                    ;    ATTRACT gamestate.

    LDY framecounter                ;  Set scroll_x with
    LDA sine, y                     ;    incremental values from
    STA scroll_x                    ;    sine lookup table.

    JMP GameLoop                    ;  End game loop.

    .org $8402                      ;  Start game loop for
GameLoopEnd:                        ;    END gamestate.

    LDA framecounter                ;  Set scroll_x equal to
    STA scroll_x                    ;    framecounter.

    JMP GameLoop                    ;  End game loop.

    .org $8502                      ;  Start NMI loop for
NMIAttractInit:                     ;    ATTRACT gamestate.

    LDA gamestate                   ;  Branch to NMIAttract if
    AND #%10000000                  ;    gamestate init flag is
    BEQ NMIAttract                  ;    0. Otherwise...

    LDX #HIGH(attract_pal)          ;  Load ATTRACT palette.
    LDY #LOW(attract_pal)           ;
    LDA #PALETTE_BG                 ;
    JSR LoadPalette                 ;

    JSR ResetBackgroundPatch        ;  Reset BG patch variables.

    JSR ClearGamestateInitFlag      ;  Clear gamestate init flag.

    JMP NMIDone                     ;  End this NMI loop.

NMIAttract:                         ;  Continue ATTRACT NMI.

    LDX #HIGH(attract_txt)          ;  Load ATTRACT text as a
    LDY #LOW(attract_txt)           ;    background patch.
    JSR LoadBackground_Patch        ;

    LDA framecounter                     ;  Set gamestate to END_INIT
    BNE NMIAttractDone              ;    after 1 second has
    LDA #END_INIT                   ;    passed.
    STA gamestate                   ;

NMIAttractDone:                     ;  End this NMI loop.
    JMP NMIDone                     ; 

    .org $8602                      ;  Start NMI loop for END
NMIEndInit:                         ;    gamestate.

    LDA gamestate                   ;  Branch to NMIEnd if 
    AND #%10000000                  ;    gamestate init flag is
    BEQ NMIEnd                      ;    0. Otherwise...

    LDX #HIGH(end_pal)              ;  Load END palette.
    LDY #LOW(end_pal)               ;
    LDA #PALETTE_BG                 ;
    JSR LoadPalette                 ;

    JSR ResetBackgroundPatch        ;  Reset BG patch variables.

    JSR ClearGamestateInitFlag      ;  Clear gamestate init flag.

    JMP NMIDone                     ;  End this NMI loop.

NMIEnd:                             ;  Continue END NMI.

    LDX #HIGH(end_txt)              ;  Load END text as a
    LDY #LOW(end_txt)               ;    background patch.
    JSR LoadBackground_Patch        ;

    LDA framecounter                      ;  Set gamestate to 
    BNE NMIEndDone                  ;    ATTRACT_INIT after 1
    LDA #ATTRACT_INIT               ;    second has passed.
    STA gamestate                   ;

NMIEndDone:                         ;  End this NMI loop.
    JMP NMIDone                     ; 

gameloop_table:                     ;  List address byte (minus
    .db $83, $01                    ;    1) for gamestate-
    .db $84, $01                    ;    specific game loop.

nmiloop_table:                      ;  List address bytes (minus
    .db $85, $01                    ;    1) for gamestate-
    .db $86, $01                    ;    specific NMI loop.