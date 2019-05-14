;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  I/O


ReadController1:
    LDA #$01
    STA GAMEPAD_1             
    LDA #$00
    STA GAMEPAD_1            
    LDX #$08
ReadController1Loop:       
    LDA GAMEPAD_1             
    LSR A   
    ROL buttons1           
    DEX     
    BNE ReadController1Loop
    LDA buttons1pending
    EOR #%11111111
    AND buttons1
    STA buttons1read
    LDA buttons1
    STA buttons1pending 
    RTS     

ReadController2:
    LDA #$01
    STA GAMEPAD_2            
    LDA #$00
    STA GAMEPAD_2              
    LDX #$08
ReadController2Loop:       
    LDA GAMEPAD_2              
    LSR A   
    ROL buttons2           
    DEX     
    BNE ReadController2Loop
    LDA buttons2pending
    EOR #%11111111
    AND buttons2
    STA buttons2read
    LDA buttons2
    STA buttons2pending
    RTS     