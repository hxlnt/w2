
AssignValues:
    LDA #$00
    STA framecounter
    STA gamestate
    STA patch_index
    STA scroll_speed_x
    STA scroll_speed_y
    LDA #$01
    STA isArrayPatch
    LDA #%10010000  
    STA ppuctrl
    LDA #%00011010
    STA ppumask

InitializeAudio:
    LDA #$00
    LDX #$00 
ClearSoundLoop:
    STA $4000, x
    INX      
    CPX #$0F 
    BNE ClearSoundLoop
    LDA #$10 
    STA $4010
    LDA #$00 
    STA $4011
    STA $4012
    STA $4013
    LDA #%00001111
    STA $4015
    ;LDA #$00 
    ;LDX #$00 
    ;JSR MUSIC_INIT