
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Scrolling subroutines


PPU_SCROLL      = $2005

Scroll:                             
    LDA scroll_speed_x              ;  Scroll in X-direction at
    AND #%10000000                  ;    speed indicated by bits
    BEQ ScrollXLeft                 ;    0-6 of scroll_speed_x
ScrollXRight:                       ;    and direction indicated
    LDA scroll_speed_x              ;    by bit 7 of
    AND #%01111111                  ;    of scroll_speed_x.
    CLC                             ;  
    ADC scroll_x                    ;    
    STA scroll_x                    ;    
    STA PPU_SCROLL                  ;    
    JMP ScrollYCheck                ;    
ScrollXLeft:                        ;    
    LDA scroll_x                    ;
    SEC                             ;
    SBC scroll_speed_x              ;
    STA scroll_x                    ;
    STA PPU_SCROLL                  ;

ScrollYCheck:                       ;  Scroll in Y-direction at
    LDA scroll_speed_y              ;    speed indicated by bits
    AND #%10000000                  ;    0-6 of scroll_speed_y
    BEQ ScrollYDown                 ;    and direction indicated
ScrollYUp:                          ;    by bit 7 of
    LDA scroll_speed_y              ;    scroll_speed_y.
    AND #%01111111                  ;
    CLC                             ;
    ADC scroll_y                    ;
    CMP #$EF                        ;
    BCS ResetScrollUp               ;
    STA scroll_y                    ;
    STA PPU_SCROLL                  ;
    RTS                             ;
ScrollYDown:                        ;
    LDA scroll_y                    ;
    SEC                             ;
    SBC scroll_speed_y              ;   
    BCC ResetScrollDown             ;
    STA scroll_y                    ;
    STA PPU_SCROLL                  ;
    RTS                             ;
ResetScrollUp:                      ;
    LDA #$00                        ;
    STA scroll_y                    ;
    STA PPU_SCROLL                  ;
    RTS                             ;
ResetScrollDown:                    ;
    LDA #$EE                        ;
    STA scroll_y                    ;
    STA PPU_SCROLL                  ;
    RTS                             ;