LoadBackground_Counter:
    STX pointer_high
    STY pointer_low
    LDA PPU_STATUS
    LDY #$00
    LDA [pointer_low], y
    STA PPU_ADDR
    INY
    LDA [pointer_low], y
    STA PPU_ADDR
    LDA displaycounter
    AND #%10000000
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%01000000
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%00100000
    LSR A
    LSR A
    LSR A
    LSR A
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%00010000
    LSR A
    LSR A
    LSR A
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%00001000
    LSR A
    LSR A
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%00000100
    LSR A
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%00000010
    LSR A
    STA PPU_DATA
    LDA displaycounter
    AND #%00000001
    STA PPU_DATA
    RTS

      
DrawResetCount:
  LDA resetflag
  CMP #$AB
  BNE DrawResetCountClear          
  JMP DrawResetCountNumber   

DrawResetCountClear:
  LDA #$AB
  STA resetflag
  LDA #'0'
  STA resetcounter
DrawResetCountNumber:
  LDA $2002
  LDA #$20
  STA $2006
  LDA #$5D
  STA $2006
  LDA resetcounter
  STA $2007
  CLC
  ADC #$01
  STA resetcounter
  RTS