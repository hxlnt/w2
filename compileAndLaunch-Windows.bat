REM This script requires that nesasm3 and fceux are on your PATH.
REM Modify as needed.

nesasm3 w2.asm
fceux -lua %~DP0build\screenshot.lua w2.nes