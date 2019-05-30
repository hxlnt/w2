PPU_SCROLL      = $2005

Scroll:
    LDA scroll_speed_x
    AND #%10000000
    BEQ ScrollXLeft
ScrollXRight:
    LDA scroll_speed_x
    AND #%01111111
    CLC
    ADC scroll_x
    STA scroll_x
    STA PPU_SCROLL
    JMP ScrollYCheck
ScrollXLeft:
    LDA scroll_x
    SEC
    SBC scroll_speed_x
    STA scroll_x
    STA PPU_SCROLL
ScrollYCheck:
    LDA scroll_speed_y
    AND #%10000000
    BEQ ScrollYDown
ScrollYUp:
    LDA scroll_speed_y
    AND #%01111111
    CLC
    ADC scroll_y
    CMP #$EF
    BCS ResetScrollUp
    STA scroll_y
    STA PPU_SCROLL
    RTS
ScrollYDown:
    LDA scroll_y
    SEC
    SBC scroll_speed_y
    BCC ResetScrollDown
    STA scroll_y
    STA PPU_SCROLL
    RTS
ResetScrollUp:
    LDA #$00
    STA scroll_y
    STA PPU_SCROLL
    RTS
ResetScrollDown:
    LDA #$EE
    STA scroll_y
    STA PPU_SCROLL
    RTS