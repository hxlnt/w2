
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  MMC1 subroutines


PRGBankWrite:                       ;  Set PRG bank number and
  LDA sourcebank                    ;    enable WRAM.
  AND #%01111111                    ;
  STA $E000                         ;
  LSR A                             ;
  STA $E000                         ;
  LSR A                             ;
  STA $E000                         ;
  LSR A                             ;
  STA $E000                         ;
  LSR A                             ;
  STA $E000                         ;
  RTS                               ;

ConfigWrite: 
  LDA #$80
  STA $8000    
  LDA bank_config
  STA $8000   
  LSR A         
  STA $8000  
  LSR A
  STA $8000
  LSR A
  STA $8000
  LSR A
  STA $8000
  RTS