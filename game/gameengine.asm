
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Game engine

    .org $8302                      ;  Start game loop for
GameLoopAttract:                    ;    ATTRACT gamestate.

    LDY framecounter                ;  Set scroll_x with
    LDA sine, y                     ;    incremental values from
    STA scroll_x                    ;    sine lookup table.

    JMP GameLoop                    ;  End game loop.

    .org $8402                      ;  Start game loop for
GameLoopEnd:                        ;    END gamestate.

    JMP GameLoop                    ;  End game loop.

    .org $8502                      ;  Start NMI loop for
NMIAttractInit:                     ;    ATTRACT gamestate.

    LDA gamestate                   ;  If init flag on gamestate
    AND #%10000000                  ;    is 0, branch to post-
    BEQ NMIAttract                  ;    init ATTRACT code.

    LDX #HIGH(attract_pal)
    LDY #LOW(attract_pal)
    LDA #PALETTE_BG
    JSR LoadPalette

    LDA gamestate                   ;  Clear init flag on
    AND #%01111111                  ;    gamestate.
    STA gamestate                   ;

    JMP NMIDone                     ;  End NMI loop.

NMIAttract:                         ;  Initialize ATTRACT.

    LDX #HIGH(attract_txt)
    LDY #LOW(attract_txt)
    JSR LoadBackground_Patch

    LDA framecounter
    BNE NMIAttractDone
    LDA #%10000010
    STA gamestate

NMIAttractDone:                     ;  End NMI loop.
    JMP NMIDone                     ; 

    .org $8602                      ;  Start NMI loop for END
NMIEndInit:                         ;    gamestate.

    LDA gamestate                   ;  If init flag on gamestate
    AND #%10000000                  ;    is 0, branch to post-
    BEQ NMIEnd                      ;    init END code.

    LDX #HIGH(end_pal)
    LDY #LOW(end_pal)
    LDA #PALETTE_BG
    JSR LoadPalette

    LDA gamestate                   ;  Clear init flag on
    AND #%01111111                  ;    gamestate.
    STA gamestate                   ;

    JMP NMIDone                     ;  End NMI loop.

NMIEnd:                             ; 

    LDX #HIGH(end_txt)
    LDY #LOW(end_txt)
    JSR LoadBackground_Patch

    LDA framecounter
    CMP #$80
    BNE NMIEndDone
    LDA #%10000000
    STA gamestate

NMIEndDone:                         ;  End NMI loop.
    JMP NMIDone                     ; 

gameloop_table:                     ;  List address byte (minus
    .db $83, $01                    ;    1) for gamestate-
    .db $84, $01                    ;    specific game loop.

nmiloop_table:                      ;  List address bytes (minus
    .db $85, $01                    ;    1) for gamestate-
    .db $86, $01                    ;    specific NMI loop.