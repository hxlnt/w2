
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Counters


Counter:                            ;  Increment framecounter.
    INC framecounter                ;

FrameCounter:                       ;  If 60 frames have passed,
    INC frames                      ;    increment seconds and
    LDA frames                      ;    reset frames to 0.
    CMP #60                         ;
    BEQ SecondCounter               ;
    RTS                             ;
SecondCounter:                      ;
    LDA #$00                        ;
    STA frames                      ;
    INC seconds                     ;

    LDA seconds                     ;  If 3,600 frames (60
    CMP #60                         ;    seconds) have passed,
    BEQ MinuteCounter               ;    increment minutes and
    RTS                             ;    reset seconds to 0.
MinuteCounter:                      ;
    LDA #$00                        ;
    STA seconds                     ;
    INC minutes                     ;
    RTS                             ;