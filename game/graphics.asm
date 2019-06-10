
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Graphics


attract_bg:                         ;  Import attract nametable.
    .incbin "game/data/attract/attract.nam"

attract_attr:                       ;  Import attract atr table.
    .incbin "game/data/attract/attract.atr"

end_bg:                             ;  Import end nametable.
    .incbin "game/data/end/end.nam" ;

end_attr:                           ;  Import end atr table.
    .incbin "game/data/end/end.atr" ;

game_bg:                            ;  Import game nametable.
    .incbin "game/data/game/game.nam"

game_attr:                          ;  Import game atr table.
    .incbin "game/data/game/game.atr"

title_bg:                           ;  Import title nametable.
    .incbin "game/data/title/title.nam"

title_attr:                         ;  Import title atr table.
    .incbin "game/data/title/title.atr"

attract_pal:                        ;  Import attract palette.
    .incbin "game/data/attract/attract.pal"

end_pal:                            ;  Import end palette.
    .incbin "game/data/end/end.pal" ;

game_pal:                           ;  Import game palette.
    .incbin "game/data/game/game.pal"

title_pal:                          ;  Import title palette.
    .incbin "game/data/title/title.pal"

attract_txt:                        ;  Import "ATTRACT" at
    .db $20, $82, %01100110         ;    $2082. Pop tiles in and
    .db "ATTRACT"

end_txt:                            ;  Import "END" at $2082.
    .db $20, $82, %01100010         ;    Pop tiles in and wait
    .db "END    "

game_txt:                           ;  Import "GAME" at $2082.
    .db $20, $82, %01100011         ;    Pop tiles in and wait
    .db "GAME"

title_txt:                          ;  Import "TITLE" at $2082.
    .db $20, $82, %01100100         ;    Pop tiles in and wait
    .db "TITLE"

attract_spr:
    .db $58, $00, $00, $78
    .db $58, $01, $00, $80                                             
    .db $60, $10, $00, $78                                             
    .db $60, $11, $00, $80                                             