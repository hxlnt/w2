
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Console initialization


PPU_CTRL        = $2000
PPU_MASK        = $2001
PPU_STATUS      = $2002

Reset:                              ;  Reset PPU.
    SEI                             ;
    CLD                             ;
    LDX #$40                        ;
    STX $4017                       ;
    LDX #$FF                        ;
    TXS                             ;
    INX                             ;
    STX PPU_CTRL                    ;
    STX PPU_MASK                    ;
    STX $4010                       ;

Vblank1:                            ;  Wait for one VBLANK.
    BIT PPU_STATUS                  ;
    BPL Vblank1                     ;

BankSetup:                          ;  Configure bankswitching
    JSR ConfigWrite                 ;    and set PRG bank 0.
    LDA #$00                        ;
    STA sourcebank                  ;
    JSR PRGBankWrite                ;

ClearMem:                           ;  Clear memory.
    LDA #$00                        ;
    STA $0000, x                    ;
    STA $0100, x                    ;
    STA $0300, x                    ;
    STA $0400, x                    ;
    STA $0500, x                    ;
    STA $0600, x                    ;
    STA $0700, x                    ;
    LDA #$FE                        ;
    STA $0200, x                    ;
    INX                             ;
    BNE ClearMem                    ;

Vblank2:                            ;  Wait for a second VBLANK.
    BIT PPU_STATUS                  ;
    BPL Vblank2                     ;

InitializeAudio:                    ;  Initialize sound
    LDA #$00                        ;    channels.
    LDX #$00                        ;   
ClearSoundLoop:                     ;
    STA $4000, x                    ;
    INX                             ;
    CPX #$0F                        ;
    BNE ClearSoundLoop              ;

    LDA #$10                        ;  Enable all sound channels
    STA $4010                       ;    except DPCM.
    LDA #$00                        ;
    STA $4011                       ;
    STA $4012                       ;
    STA $4013                       ;
    LDA #%00001111                  ;
    STA $4015                       ;

    ;LDA #$00                       ;  Initialize music.
    ;LDX #$00                       ;
    ;JSR MUSIC_INIT                 ;

    LDA #$00                        ;  Clear framecounter,
    STA framecounter                ;    gamestate,
    STA gamestate                   ;    patch_index, and X- and
    STA patch_index                 ;    Y- scroll speeds.
    STA scroll_speed_x              ;
    STA scroll_speed_y              ;