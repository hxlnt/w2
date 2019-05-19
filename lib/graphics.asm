;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  GRAPHICS ROUTINES


LoadBackground_All:                 ;  Loads full screen of graphics
    LDA PPU_STATUS
    STY PPU_ADDR
    LDY #$00
    STY PPU_ADDR
    STY pointer_low
    STX pointer_high
    LDX #$04
Load256Tiles:
    LDA [pointer_low], y
    STA PPU_DATA
    INY
    BNE Load256Tiles 
    INC pointer_high
    DEX
    BNE Load256Tiles
    RTS

LoadBackground_Column:              ;  Loads one column of graphics
    RTS

LoadBackground_Row:
    RTS

LoadBackground_Popcorn:             ;  Untested subroutine
    LDA framecounter
    AND #%00000111
    CMP #%00000111
    BNE LoadBackground_PopcornSkip
    STX pointer_high
    STY pointer_low
    LDA PPU_STATUS
    LDY #$00
    LDA [pointer_low], y
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    CLC
    ADC popcorn_index
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    STA popcorn_length
    LDA popcorn_index
    CLC
    ADC #$03
    AND #%00011111
    TAY
    LDA [pointer_low], y
    STA PPU_DATA
    LDX popcorn_index
    INX
    STX popcorn_index
    LDA popcorn_length
    CMP popcorn_index
    BEQ LoadBackground_PopcornDone
    RTS
LoadBackground_PopcornDone:
    LDA #$00
    STA isArrayPopcorn
LoadBackground_PopcornSkip:
    RTS

LoadBackground_Array:
    STX pointer_high
    STY pointer_low
    LDA PPU_STATUS
    LDY #$00
    LDA [pointer_low], y
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    CLC
    ADC #$06                        ;  Add 2 to accommodate for the fact that Y
    AND #%00011111
    STA msg_end                     ;  already equals 2
    INY
LoadBackground_ArrayLoop:
    LDA [pointer_low], y
    STA PPU_DATA
    INY
    CPY msg_end
    BNE LoadBackground_ArrayLoop 
    RTS

LoadBackground_Single:
    RTS

LoadPalette_All:              
    LDA PPU_STATUS   
    LDA #$3F    
    STA PPU_ADDR   
    STY PPU_ADDR
    STX pointer_high
LoadPalette_BGLoop:
    LDA [pointer_low], y
    STA PPU_DATA
    INY
    CPY #$20
    BNE LoadPalette_BGLoop
    RTS

LoadPalette_SprColors:
    LDA PPU_STATUS   
    LDA #$3F    
    STA PPU_ADDR   
    STY PPU_ADDR
    STX pointer_high
LoadPaletteLoop:
    LDA [pointer_low], y
    STA PPU_DATA
    INY
    CPY #$20
    BNE LoadPaletteLoop
    RTS

LoadPalette_1Color:
    RTS

LoadAttr_All:
    LDA #$23    
    STA PPU_ADDR   
    LDA #$c0    
    STA PPU_ADDR   
    LDX #$00    
LoadAttr_AllLoop:   
    LDA attract_attr, x 
    STA PPU_DATA   
    INX         
    CPX #$40    
    BNE LoadAttr_AllLoop 
    RTS  

SpriteDMA:
    LDA #$00
    STA OAM_ADDR  
    LDA #$03
    STA OAM_DMA   
    RTS    

Scroll:
    LDA scroll
    AND #%01110000
    LSR A
    LSR A
    LSR A
    LSR A
    STA scroll_speed
    LDA scroll
    AND #%10000000
    BEQ ScrollXLeft
ScrollXRight:
    LDA scroll_x
    CLC
    ADC scroll_speed
    STA scroll_x
    STA PPU_SCROLL
    JMP ScrollYCheck
ScrollXLeft:
    LDA scroll_x
    SEC 
    SBC scroll_speed
    STA scroll_x
    STA PPU_SCROLL
ScrollYCheck:
    LDA scroll
    AND #%00000111
    STA scroll_speed
    LDA scroll
    AND #%00001000
    BEQ ScrollYDown
ScrollYUp:
    LDA scroll_y
    CLC
    ADC scroll_speed
    ;CMP #$EF
    ;BCS ResetScrollUp
    STA scroll_y
    STA PPU_SCROLL
    RTS
ScrollYDown:
    LDA scroll_y
    SEC
    SBC scroll_speed
    ;CMP #$01
    ;BCC ResetScrollDown
    STA scroll_y
    STA PPU_SCROLL
    RTS
ResetScrollUp:
    LDA #$00
    STA scroll_y
    STA PPU_SCROLL
    RTS
ResetScrollDown:
    LDA #$ED
    STA scroll_y
    STA PPU_SCROLL
    RTS

;; TODO --> Think about object model
LoadSpr:
    LDX #$00    
LoadSprLoop:    
    ;LDA heart,x 
    LDA #$01
    STA $0300,x 
    INX         
    CPX #$20    
    BNE LoadSprLoop  
    RTS                                          

TurnScreenOn:
    LDA #%10010000   
    STA PPU_CTRL
    LDA #%00011010   
    STA PPU_MASK
    RTS         

TurnScreenOff:
    LDA #$00    
    STA PPU_CTRL
    STA PPU_MASK
    RTS         
