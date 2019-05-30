;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  VARIABLES


music           .rs 16              ;  Leave the first 16 bytes free for music
buttons1        .rs 1               ;  Gamepad read (P1)
buttons1pending .rs 1               ;  Temporary storage for gamepad read (P1)
buttons1read    .rs 1               ;  Useful (debounced) gamepad read (P1)
buttons2        .rs 1               ;  Gamepad read (P2)
buttons2pending .rs 1               ;  Temporary storage for gamepad read (P2)
buttons2read    .rs 1               ;  Useful (debounced) gamepad read (P2)
framecounter    .rs 1               ;  General-purpose frame counter
frames          .rs 1
seconds         .rs 1               ;  Second counter
minutes         .rs 1               ;  Minute counter
gamestate       .rs 1               ;  General-purpose gamestate tracker
pointer_low     .rs 1   
pointer_high    .rs 1
scroll_x        .rs 1               ;  Stores X-value of scroll
scroll_y        .rs 1               ;  Stores Y-value of scroll
scroll_speed_x  .rs 1               ;  %Dsssssss
                                    ;   |+++++++ Scroll speed
                                    ;   +------- Scroll direction (0=left, 1=right)
scroll_speed_y  .rs 1               ;  %Dsssssss
                                    ;   |+++++++ Scroll speed
                                    ;   +------- Scroll direction (0=up, 1=down)
msg_end         .rs 1               ;  Number of background tiles to be loaded simulatenously
isArrayPatch    .rs 1               ;  True if array should pop in one tile at a time
patch_index     .rs 1               ;  Index in dialog row
patch_length    .rs 1
sourcebank      .rs 1
ppuctrl         .rs 1
ppumask         .rs 1
bank_config     .rs 1