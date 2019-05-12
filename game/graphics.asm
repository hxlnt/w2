attract_bg:
    .incbin "game/data/attract/attract.nam"
attract_attr:
    .incbin "game/data/attract/attract.atr"
end_bg:
    .incbin "game/data/end/end.nam"
end_attr:
    .incbin "game/data/end/end.atr"
game_bg:
    .incbin "game/data/game/game.nam"
game_attr:
    .incbin "game/data/game/game.atr"
title_bg:
    .incbin "game/data/title/title.nam"
title_attr:
    .incbin "game/data/title/title.atr"

attract_pal:
    .incbin "game/data/attract/attract.pal"
end_pal:
    .incbin "game/data/end/end.pal"
game_pal:
    .incbin "game/data/game/game.pal"
title_pal:
    .incbin "game/data/title/title.pal"


attract_txt:
    .db $20, $82, %01100110
    .db "ATTRACT"

end_txt:
    .db $20, $82, %01100010
    .db "END"

game_txt:
    .db $20, $82, %01100011
    .db "GAME"

title_txt:
    .db $20, $82, %01100100
    .db "TITLE"