# cutelib

`cutelib` is yet another library of reusable NES code. It handles console initialization, I/O, graphics loading, audio, and more. 


## console_init.asm

**Description**  Initializes NES.

**Usage**  Add `.include console_init.asm` at top of first PRG bank.


## counters.asm

**Description**  Increments `framecounter` every frame (approx. 60 times/second), increments `seconds` every 60 frames (approx. 60 times/minute), and increments `minutes` every 3,600 frames (approx. 1 time/minute). `minutes` rolls over to 0 after 255 minutes (`#$FF`).

**Usage**  `JSR Counter` during NMI.


## graphics.asm

**Description**  Provides numerous subroutines for loading background graphics, sprites, and palettes.

**Usage**  See table below for usage information.

| Subroutine | Description | Example usage |
|------------|-------------|---------------|
| LoadAttr_All | Loads all attribute data as follows:<BR>`example_attr:`<BR>&nbsp;&nbsp;`.incbin "game/data/example/example.atr"`<BR>The attribute data must be placed immediately after the corresponding nametable data. | `LDX #HIGH(example_attr)`<BR>`LDY #NMTBL_TOP_LEFT`<BR>`JSR LoadAttr_All`<BR><BR>Possible values for Y are `#NMTBL_TOP_LEFT`, `#NMTBL_TOP_RIGHT`, `#NMTBL_BOT_LEFT`, and `#NMTBL_BOT_RIGHT`. |
| LoadBackground_All | Loads a full nametable of background tiles where the low byte of tile data is equal to `$00`. | `LDX #HIGH(background_tiles)`<BR>`LDY #NMTBL_TOP_LEFT`<BR>`JSR LoadBackground_All`<BR><BR>Possible values for Y are `#NMTBL_TOP_LEFT`, `#NMTBL_TOP_RIGHT`, `#NMTBL_BOT_LEFT`, and `#NMTBL_BOT_RIGHT`. |
| LoadBackground_Patch | Loads sequential background tiles, one nametable row at a time, in the following data format:<BR>`patch:`<BR>&nbsp;&nbsp;`.db $[high byte of nametable addr], $[low byte of nametable addr], %[control code]`<BR>&nbsp;&nbsp;`.db $[tile], $[tile], ... $[tile]`<BR><BR>Control code:<BR>`UIPnnnnn`<BR>` lll+++++ Line length (0-indexed)`<BR>` ll+----- Do tiles pop in one at a time? (Boolean)`<BR>` l+------ Wait for input? (Boolean)`<BR>` l+------ Unused` | `LDX #HIGH(patch)`<BR>`LDY #LOW(patch)`<BR>`JSR LoadBackground_Patch` |
| LoadPalette_All | Loads all palette data as follows:<BR>`example_pal:`<BR>&nbsp;&nbsp;`.incbin "game/data/example/example.pal"` | `LDX #HIGH(example_pal)`<BR>`LDY #LOW(example_pal)`<BR>`JSR LoadPalette_All` |
| TurnScreenOff | Disables screen rendering. | `JSR TurnScreenOff` |
| TurnScreenOn | Enables NMI, sets sprite height, selects background/sprite addresses, sets VRAM address increment mode, and sets base nametable address.<BR>`VPHBSINN`<BR>`llllll++ Base nametable address (00 = $2000, 01 = $2400, 10 = $2800, 11 = $2C00)`<BR>`lllll+-- VRAM address increment per CPU read (0 = add 1, 1 = add 32)`<BR>`llll+--- Sprite pattern table address for 8x8 mode (0 = $0000, 1 = $1000)`<BR>`lll+---- Background pattern table address (0 = $0000, 1 = $1000)`<BR>`ll+----- Sprite size (0 = 8x8, 1 = 8x16)`<BR>`l+------ PPU master/slave select (Set to 0)`<BR>`+------- Generate NMI at the start of VBlank (Boolean)` | `JSR TurnScreenOn` |

## io.asm

**Description**  Handles gamepad reading.

**Usage**  `JSR ReadGamepad1` and `JSR ReadGamepad2`.


## lookup_tables.asm

**Description**  Contains lookup tables ("pre-calcs") as arrays of bytes.

**Usage**  See table below for usage information.

| Lookup table | Description | Example usage |
|--------------|-------------|---------------|
| sine         | A 255-value sine wave that begins and ends at `#$80`. |  `LDY framecounter`<BR>`LDA sine, y`<BR>`STA scroll_x` |


## mmc1.asm

**Description**  Contains subroutines used for MMC1 such as bankswitching.

**Usage**  See table below for usage information.

| Subroutine | Description | Example usage |
|------------|-------------|---------------|
| ConfigWrite | Sets mirroring, size of banks, etc. as indicated by value in `bank_config`. | Add `.include mmc1.asm` in last PRG bank. |
| PRGBankWrite | Sets bank to switch. | Add `.include mmc1.asm` in last PRG bank.<BR><BR>`LDA #$00`<BR>`JSR PRGBankWrite` |


## scroll.asm

**Description**  Sets X- and Y-scrolling for background.

**Usage**  See table below for usage information.

| Subroutine | Description | Example usage |
|------------|-------------|---------------|
| Scroll     | Updates X- and Y-scroll values based on `scroll_speed_x` and `scroll_speed_y`.<BR><BR>scroll_speed_x:<BR>`Dsssssss`<BR>`l+++++++ Scroll speed`<BR>`+------- Scroll direction (0=left, 1=right)`<BR><BR>scroll_speed_y:<BR>`Dsssssss`<BR>`l+++++++ Scroll speed`<BR>`+------- Scroll direction (0=up, 1=down)` | `JSR Scroll` |


## variables.asm

**Description**  Variables used by `cutelib`.

**Usage**  Add `.include "lib/variables.asm"` at zero page (after `.rsset $0000`). 