# c64-assembly
A 6502-based Commodore 64 assembly language repo for OSX and Ubuntu.  This is a very small and targeted OSX and Ubuntu port based on the original work of Chibi Akumas.

## Download
[vasm](http://sun.hasenbraten.de/vasm/index.php?view=source)<br>
[VICE *OSX*](https://vice-emu.sourceforge.io/index.html#download)<br>
[VICE *Ubuntu*](https://snapcraft.io/vice-jz)

## Installing
```bash
tar -xvf vasm.tar.gz
cd vasm
make CPU=6502 SYNTAX=oldstyle
cd ..
hdiutil attach vice-sdl2-3.4-r37694.dmg
cp -av /Volumes/vice-sdl2-3.4-r37694/vice-sdl2-3.4-r37694/ .
chmod +x run.sh

```

## Running VICE
*OSX*
```bash
./x64sc.app/Contents/MacOS/x64sc
```
*Ubuntu*
```bash
Commodore 64 [CLICK FOUR DOTS -> Show Applications]
```
* Within VICE if you are on OSX use F10 to get a menu structure.  The Ubuntu structure will mimic much of the Windows VICE emulator.  In either case you need to Automount your file within the ./BldC64/Lesson1.prg directory to run your program within the emulator.


## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0/)
