;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  I/O
GAMEPAD_A       = %10000000         ;;;;;; Controller button presses
GAMEPAD_B       = %01000000
GAMEPAD_SELECT  = %00100000
GAMEPAD_START   = %00010000
GAMEPAD_UP      = %00001000
GAMEPAD_DOWN    = %00000100
GAMEPAD_LEFT    = %00000010
GAMEPAD_RIGHT   = %00000001

GAMEPAD_1       = $4016
GAMEPAD_2       = $4017

ReadGamepad1:
    LDA #$01
    STA GAMEPAD_1             
    LDA #$00
    STA GAMEPAD_1            
    LDX #$08
ReadGamepad1Loop:       
    LDA GAMEPAD_1             
    LSR A   
    ROL buttons1           
    DEX     
    BNE ReadGamepad1Loop
    LDA buttons1pending
    EOR #%11111111
    AND buttons1
    STA buttons1read
    LDA buttons1
    STA buttons1pending 
    RTS     

ReadGamepad2:
    LDA #$01
    STA GAMEPAD_2            
    LDA #$00
    STA GAMEPAD_2              
    LDX #$08
ReadGamepad2Loop:       
    LDA GAMEPAD_2              
    LSR A   
    ROL buttons2           
    DEX     
    BNE ReadGamepad2Loop
    LDA buttons2pending
    EOR #%11111111
    AND buttons2
    STA buttons2read
    LDA buttons2
    STA buttons2pending
    RTS     