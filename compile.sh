#!/bin/bash

./vasm/vasm6502_oldstyle ./Source/Lesson1.asm -cbm-prg -chklabels -nocase -Dvasm=1  -L ./BldC64/Listing.txt -DBuildC64=1 -Fbin -o "./BldC64/Lesson1.prg"

