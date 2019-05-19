| File             | Subroutine | Description | Usage |
|------------------|------------|-------------|-------|
| console_init.asm | N/A        | Initializes NES | `.include console_init.asm` at top of first PRG bank. |
| counters.asm | Counter    | Increments `framecounter` once every frame. Increments `secondcounter` once every 60 frames. Increments `minutecounter` once every 3,600 frames with rollover at `$FF`. | `JSR Counter` during NMI. |
| graphics.asm     | LoadBackground_All | Loads a full nametable of background tiles where the low byte of tile data is equal to `$00`. | `LDX #HIGH(background_tiles)`<BR>`LDY #NMTBL_TOP_LEFT`<BR>`JSR LoadBackground_All` |