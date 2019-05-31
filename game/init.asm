
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Initialization


    LDA #$01                        ;  Set flag to prepare
    STA isArrayPatch                ;    LoadBackground_Patch.

    LDA #%00000111                  ;  Set speed at which patch
    STA patch_speed                 ;    tiles pop in.

    LDA #%10010000                  ;  Set PPU_CTRL values.
    STA ppuctrl                     ;

    LDA #%00011010                  ;  Set PPU_MASK values.
    STA ppumask                     ;