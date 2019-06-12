scroll_sine:
    LDY framecounter                ;  Set scroll_x with
    LDA sine, y                     ;    incremental values from
    STA scroll_x                    ;    sine lookup table.