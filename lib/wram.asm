PRGBankWrite:     ; make sure this is in last bank so it doesnt get swapped away
  LDA sourcebank  ; load bank number into A
  AND #%01111111  ; clear the WRAM bit so it is always enabled
  STA $E000       ; first data bit
  LSR A           ; shift to next bit
  STA $E000
  LSR A
  STA $E000
  LSR A
  STA $E000
  LSR A
  STA $E000
  RTS

ConfigWrite:     ; make sure this is in the last PRG bank so the RTS doesn't get swapped away
  LDA #$80
  STA $8000      ; reset the shift register
  
  LDA #%00001110 ; 8KB CHR, 16KB PRG, $8000-BFFF swappable, vertical mirroring
  STA $8000      ; first data bit
  LSR A          ; shift to next bit
  STA $8000      ; second data bit
  LSR A          ; etc
  STA $8000
  LSR A
  STA $8000
  LSR A
  STA $8000
  RTS