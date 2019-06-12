
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Game engine

    .org $8302
    LDY framecounter                ;  Set scroll_x with
    LDA sine, y                     ;    incremental values from
    STA scroll_x                    ;    sine lookup table.
    JMP GameLoop

    .org $8402
    LDA #$00
    STA scroll_x
    JMP GameLoop

    .org $8502
    JSR Counter
    JMP NMIDone

    .org $8602
    JMP NMIDone

; $827F
gameloop_table:
    .db $83, $01
    .db $84, $01

nmiloop_table:
    .db $85, $01
    .db $86, $01