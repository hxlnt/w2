
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Counters


Counter:                            ;  Increment framecounter.
    INC framecounter                ;

FrameCounter:                       ;  Increment seconds and
    INC frames                      ;    reset frames to 0 if 60
    LDA frames                      ;    frames have passed.
    CMP #60                         ;
    BEQ SecondCounter               ;
    RTS                             ;
SecondCounter:                      ;
    LDA #$00                        ;
    STA frames                      ;
    INC seconds                     ;

    LDA seconds                     ;  Increment minutes and
    CMP #60                         ;    reset seconds to 0 if
    BEQ MinuteCounter               ;    3,600 frames (60
    RTS                             ;    seconds) have passed.
MinuteCounter:                      ;
    LDA #$00                        ;
    STA seconds                     ;
    INC minutes                     ;
    RTS                             ;