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
chmod +x run.sh

```


## Running

```bash
python pi_zork_server.py
python pi_zork_client.py
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0/)
