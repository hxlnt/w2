
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  I/O subroutines


GAMEPAD_1       = $4016
GAMEPAD_2       = $4017
GAMEPAD_A       = %10000000
GAMEPAD_B       = %01000000
GAMEPAD_DOWN    = %00000100
GAMEPAD_LEFT    = %00000010
GAMEPAD_RIGHT   = %00000001
GAMEPAD_SELECT  = %00100000
GAMEPAD_START   = %00010000
GAMEPAD_UP      = %00001000

ReadGamepad1:                       ;  Read input from
    LDA #$01                        ;    gamepad 1.
    STA GAMEPAD_1                   ;
    LDA #$00                        ;
    STA GAMEPAD_1                   ;
    LDX #$08                        ;
ReadGamepad1Loop:                   ;
    LDA GAMEPAD_1                   ;
    LSR A                           ;
    ROL buttons1                    ;
    DEX                             ;
    BNE ReadGamepad1Loop            ;

    LDA buttons1pending             ;  Store real-time
    EOR #%11111111                  ;    button presses in
    AND buttons1                    ;    buttons1. Store
    STA buttons1read                ;    "debounced" button
    LDA buttons1                    ;    presses in
    STA buttons1pending             ;    buttons1read.
    RTS                             ;     

ReadGamepad2:                       ;  Read input from
    LDA #$01                        ;    gamepad 2.
    STA GAMEPAD_2                   ;
    LDA #$00                        ;
    STA GAMEPAD_2                   ;
    LDX #$08                        ;
ReadGamepad2Loop:                   ;
    LDA GAMEPAD_2                   ;
    LSR A                           ;
    ROL buttons2                    ;
    DEX                             ;
    BNE ReadGamepad2Loop            ;

    LDA buttons2pending             ;  Store real-time
    EOR #%11111111                  ;    button presses in
    AND buttons2                    ;    buttons2. Store
    STA buttons2read                ;    "debounced" button
    LDA buttons2                    ;    presses in
    STA buttons2pending             ;    buttons2pending.
    RTS                             ;