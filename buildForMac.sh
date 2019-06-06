#!/bin/sh

nesasm -s w2.asm
open w2.nes
sleep 1
screenshot OpenEmu --filename "build/screenshot.png"