
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Graphics subroutines


PPU_ADDR        = $2006
PPU_DATA        = $2007
NMTBL_TOP_LEFT  = $20               
NMTBL_TOP_RIGHT = $24
NMTBL_BOT_LEFT  = $28
NMTBL_BOT_RIGHT = $2C
OAM_ADDR        = $2003            
OAM_DATA        = $2004
OAM_DMA         = $4014
PALETTE_BG      = $00              
PALETTE_SPR     = $10

LoadBackground_All:                 ;  Load full nametable.

    LDA PPU_STATUS                  ;  Set PPU address to
    STY PPU_ADDR                    ;    $[Y]00.
    LDY #$00                        ; 
    STY PPU_ADDR                    ;

    STY pointer_low                 ;  Set nametable address to
    STX pointer_high                ;    $[X]00 and load all
    LDX #$04                        ;    1,024 tiles.
Load256Tiles:                       ;
    LDA [pointer_low], y            ;
    STA PPU_DATA                    ;
    INY                             ;
    BNE Load256Tiles                ;
    INC pointer_high                ;
    DEX                             ;
    BNE Load256Tiles                ;
    RTS                             ;

LoadBackground_Patch:               ;  Load nametable patch.

    LDA isArrayPatch                ;  Return from subroutine if
    BEQ LoadBackground_PatchDone    ;    patch is done loading.

    LDA framecounter                ;  Return from subroutine if
    AND patch_speed                 ;    framecounter is not a
    CMP patch_speed                 ;    multiple of 
    BNE LoadBackground_PatchSkip    ;    patch_speed.
    
    STX pointer_high                ;  Set PPU address to first
    STY pointer_low                 ;    two bytes of patch
    LDA PPU_STATUS                  ;    data.
    LDY #$00                        ;
    LDA [pointer_low], y            ;
    STA PPU_ADDR                    ;
    INY                             ;
    LDA [pointer_low], y            ;
    CLC                             ;
    ADC patch_index                 ;
    STA PPU_ADDR                    ;

    INY                             ;  Determine how many
    LDA [pointer_low], y            ;    times to iterate
    AND #%0001111                   ;    through this
    STA patch_length                ;    subroutine.

    LDA patch_index                 ;  Write current tile to the
    CLC                             ;    screen.
    ADC #$03                        ;
    TAY                             ;
    LDA [pointer_low], y            ;
    STA PPU_DATA                    ;

    LDA patch_length                ;  Set isArrayPatch flag to
    CMP patch_index                 ;    false if all of the
    BEQ LoadBackground_PatchDone    ;    background patch has 
    LDX patch_index                 ;    been written to the
    INX                             ;    screen.
    STX patch_index                 ;
    RTS                             ;
LoadBackground_PatchDone:           ;
    LDA #$00                        ;
    STA isArrayPatch                ;
LoadBackground_PatchSkip:           ;
    RTS                             ;

LoadPalette_All:                    ;  Load BG and SPR
    LDA PPU_STATUS                  ;    palette data
    LDA #$3F                        ;    stored at $[X][Y].
    STA PPU_ADDR                    ;    
    LDA #$00                        ;
    STA PPU_ADDR                    ;
    STX pointer_high                ;
    STY pointer_low                 ;
    LDY #$00                        ;
LoadPalette_BGLoop:                 ;
    LDA [pointer_low], y            ;
    STA PPU_DATA                    ;
    INY                             ;
    CPY #$20                        ;
    BNE LoadPalette_BGLoop          ;
    RTS                             ;

LoadAttr_All:                       ;  Load attribute table
    TYA                             ;    data stored at
    CLC                             ;    $[X]C0 to PPU
    ADC #$03                        ;    address $[Y+3]C0.
    STA PPU_ADDR                    ;
    LDA #$C0                        ;
    STA PPU_ADDR                    ;
    STA pointer_low                 ;
    STX pointer_high                ;
    LDY #$00                        ;
LoadAttr_AllLoop:                   ;
    LDA [pointer_low], y            ;
    STA PPU_DATA                    ;
    INY                             ;
    CPY #$40                        ;
    BNE LoadAttr_AllLoop            ;
    RTS                             ;        

TurnScreenOn:                       ;  Turn screen on.
    LDA ppuctrl                     ;
    STA PPU_CTRL                    ;
    LDA ppumask                     ;
    STA PPU_MASK                    ;
    RTS                             ;

TurnScreenOff:                      ;  Turn screen off.
    LDA #$00                        ;
    STA PPU_CTRL                    ;
    STA PPU_MASK                    ;
    RTS                             ;
