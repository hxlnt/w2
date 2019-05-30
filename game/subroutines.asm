
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Custom subroutines

      
DrawResetCount:                     ;  Compare resetflag to #$AB
  LDA resetflag                     ;    to see if console has
  CMP #$AB                          ;    been reset before. If
  BNE DrawResetCountClear           ;    it has not, set
  JMP DrawResetCountNumber          ;    resetflag to #$AB and
DrawResetCountClear:                ;    set resetcounter to the
  LDA #$AB                          ;    ASCII value '0'.
  STA resetflag                     ;
  LDA #'0'                          ;  
  STA resetcounter                  ;    

DrawResetCountNumber:               ;  Draw the value stored in
  LDA $2002                         ;    resetcounter to the 
  LDA #$20                          ;    screen at address
  STA $2006                         ;    $205D.
  LDA #$5D                          ;
  STA $2006                         ;
  LDA resetcounter                  ;
  STA $2007                         ;

  CLC                               ;  Increment the value in
  ADC #$01                          ;    resetcounter for the
  STA resetcounter                  ;    next time the console
  RTS                               ;    is reset.