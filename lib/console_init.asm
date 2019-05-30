PPU_CTRL        = $2000             ;;;;;; PPU registers
PPU_MASK        = $2001
PPU_STATUS      = $2002

Reset:
    SEI      
    CLD      
    LDX #$40 
    STX $4017
    LDX #$FF 
    TXS      
    INX      
    STX PPU_CTRL
    STX PPU_MASK
    STX $4010
Vblank1:
    BIT PPU_STATUS
    BPL Vblank1 
BankSetup:
    JSR ConfigWrite
    LDA #$00
    STA sourcebank
    JSR PRGBankWrite
ClearMem:
    LDA #$00 
    STA $0000, x
    STA $0100, x
    STA $0300, x
    STA $0400, x
    STA $0500, x
    STA $0600, x
    STA $0700, x
    LDA #$FE 
    STA $0200, x
    INX      
    BNE ClearMem
Vblank2:
    BIT PPU_STATUS
    BPL Vblank2