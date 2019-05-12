Counter:
    INC framecounter
FrameCounter:
    INC frames
    LDA frames
    CMP #60
    BEQ SecondCounter
    RTS
SecondCounter:
    LDA #$00
    STA frames
    INC seconds
    LDA seconds
    CMP #60
    BEQ MinuteCounter
    RTS
MinuteCounter:
    LDA #$00
    STA seconds
    INC minutes
    RTS