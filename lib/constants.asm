                                        ;;;;;; CONSTANTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


GAMEPAD_A       = %10000000         ;;;;;; Controller button presses
GAMEPAD_B       = %01000000
GAMEPAD_SELECT  = %00100000
GAMEPAD_START   = %00010000
GAMEPAD_UP      = %00001000
GAMEPAD_DOWN    = %00000100
GAMEPAD_LEFT    = %00000010
GAMEPAD_RIGHT   = %00000001

PPU_CTRL        = $2000             ;;;;;; PPU registers
PPU_MASK        = $2001
PPU_STATUS      = $2002
PPU_SCROLL      = $2005
PPU_ADDR        = $2006
PPU_DATA        = $2007

OAM_ADDR        = $2003             ;;; Sprite registers
OAM_DATA        = $2004
OAM_DMA         = $4014

GAMEPAD_1       = $4016
GAMEPAD_2       = $4017

NMTBL_TOP_LEFT  = $20               ;;;;;; High byte of nametable addresses
NMTBL_TOP_RIGHT = $24
NMTBL_BOT_LEFT  = $28
NMTBL_BOT_RIGHT = $2C

PALETTE_BG      = $00               ;;;;;; Low byte of palette addresses
PALETTE_SPR     = $10