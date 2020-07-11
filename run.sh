#!/bin/bash

./vasm6502_oldstyle ./Source/Lesson1.asm -cbm-prg -chklabels -nocase -Dvasm=1  -L ./BldC64/Listing.txt -DBuildC64=1 -Fbin -o "./BldC64/Program.prg"

#./vice/x64sc.app/Contents/MacOS/x64sc ./BldC64/Program.prg

