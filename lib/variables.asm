
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Scrolling subroutines

music           .rs 16              ;  Leave 16 bytes for music.
bank_config     .rs 1               ;  Store bank config.
buttons1        .rs 1               ;  Store gamepad 1 reads.
buttons1pending .rs 1               ;  Store temporary reads.
buttons1read    .rs 1               ;  Store debounced reads.
buttons2        .rs 1               ;  Store gamepad 2 reads.
buttons2pending .rs 1               ;  Store temporary reads.
buttons2read    .rs 1               ;  Store debounced reads.    
framecounter    .rs 1               ;  Store frames elapse.
frames          .rs 1               ;  Store temporary count.
gamestate       .rs 1               ;  Store game state.
isPatchDone     .rs 1               ;  Store BG patch flag.
minutes         .rs 1               ;  Store minutes elapsed.
patch_index     .rs 1               ;  Store BG patch index.
patch_length    .rs 1               ;  Store BG patch length.
patch_speed     .rs 1               ;  Store BG patch speed.
ppuctrl         .rs 1               ;  Store PPU_CTRL value.
ppumask         .rs 1               ;  Store PPU_MASK value.
pointer_low     .rs 1               ;  Store address low byte.
pointer_high    .rs 1               ;  Store address high byte.
scroll_speed_x  .rs 1               ;  %Dsssssss
                                    ;   |+++++++ Store speed.
                                    ;   +------- Store dir.
scroll_speed_y  .rs 1               ;  %Dsssssss
                                    ;   |+++++++ Store speed.
                                    ;   +------- Store dir.
scroll_x        .rs 1               ;  Store X-value of scroll.
scroll_y        .rs 1               ;  Store Y-value of scroll.
seconds         .rs 1               ;  Store seconds elapsed.
sourcebank      .rs 1               ;  Store PRG bank number.
spr_length      .rs 1               ;  Store sprite data size.

