| File             | Subroutine | Description | Usage |
|------------------|------------|-------------|-------|
| console_init.asm | N/A        | Initializes NES | `.include console_init.asm` at top of first PRG bank. |
| counters.asm | Counter    | Increments `framecounter` once every frame. Increments `secondcounter` once every 60 frames. Increments `minutecounter` once every 3,600 frames with rollover at `$FF`. | `JSR Counter` during NMI. |
| graphics.asm     | LoadBackground_All | Loads a full nametable of background tiles where the low byte of tile data is equal to `$00`. | `LDX #HIGH(background_tiles)`<BR>`LDY #NMTBL_TOP_LEFT`<BR>`JSR LoadBackground_All` |
| graphics.asm     | LoadBackground_Patch | Loads sequential background tiles, one nametable row at a time, in the following data format:<BR>`patch:`<BR>`    .db $[high byte of nametable addr], $[low byte of nametable addr], %[control code]`<BR>`    .db $[tile], $[tile], ... $[tile]`<BR><BR>Control code:<BR>`%UIPnnnnn`<BR>` |||+++++ Line length (0-indexed)`<BR>` ||+----- Do tiles pop in one at a time? (Boolean)`<BR>` |+------ Wait for input? (Boolean)`<BR>` +------- Unused` | `LDX #HIGH(patch)`<BR>`LDY #LOW(patch)`<BR>`JSR LoadBackground_Patch`