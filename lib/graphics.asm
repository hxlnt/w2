;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  GRAPHICS ROUTINES
PPU_ADDR        = $2006
PPU_DATA        = $2007

NMTBL_TOP_LEFT  = $20               ;;;;;; High byte of nametable addresses
NMTBL_TOP_RIGHT = $24
NMTBL_BOT_LEFT  = $28
NMTBL_BOT_RIGHT = $2C

OAM_ADDR        = $2003             ;;; Sprite registers
OAM_DATA        = $2004
OAM_DMA         = $4014

PALETTE_BG      = $00               ;;;;;; Low byte of palette addresses
PALETTE_SPR     = $10

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

LoadBackground_Patch:             ;  Untested subroutine
    LDA isArrayPatch
    BEQ LoadBackground_PatchDone
    LDA framecounter
    AND #%00000111
    CMP #%00000111
    BNE LoadBackground_PatchSkip
    STX pointer_high
    STY pointer_low
    LDA PPU_STATUS
    LDY #$00
    LDA [pointer_low], y
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    CLC
    ADC patch_index
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    AND #%0001111
    STA patch_length
    LDA patch_index
    CLC
    ADC #$03
    TAY
    LDA [pointer_low], y
    STA PPU_DATA
    LDA patch_length
    CMP patch_index
    BEQ LoadBackground_PatchDone
    LDX patch_index
    INX
    STX patch_index
    RTS
LoadBackground_PatchDone:
    LDA #$00
    STA isArrayPatch
LoadBackground_PatchSkip:
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

LoadPalette_All:              
    LDA PPU_STATUS   
    LDA #$3F    
    STA PPU_ADDR   
    LDA #$00
    STA PPU_ADDR
    STX pointer_high
    STY pointer_low
    LDY #$00
LoadPalette_BGLoop:
    LDA [pointer_low], y
    STA PPU_DATA
    INY
    CPY #$20
    BNE LoadPalette_BGLoop
    RTS

LoadPalette_1Color:
    RTS

LoadAttr_All:
    TYA
    CLC
    ADC #$03
    STA PPU_ADDR   
    LDA #$C0    
    STA PPU_ADDR  
    STA pointer_low
    STX pointer_high
    LDY #$00
LoadAttr_AllLoop:   
    LDA [pointer_low], y
    STA PPU_DATA   
    INY       
    CPY #$40    
    BNE LoadAttr_AllLoop 
    RTS

SpriteDMA:
    LDA #$00
    STA OAM_ADDR
    LDA #$03
    STA OAM_DMA   
    RTS    

;; TODO --> Think about object model
;LoadSpr:
;    LDX #$00    
;LoadSprLoop:    
;    ;LDA heart,x 
;    LDA #$01
;    STA $0300,x 
;    INX         
;    CPX #$20    
;    BNE LoadSprLoop  
;    RTS                                          

TurnScreenOn:
    LDA ppuctrl   
    STA PPU_CTRL
    LDA ppumask  
    STA PPU_MASK
    RTS         

TurnScreenOff:
    LDA #$00    
    STA PPU_CTRL
    STA PPU_MASK
    RTS         
