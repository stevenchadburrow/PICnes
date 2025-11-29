./dev65/bin/as65 NesGameDev-ProgramROM.asm ;
./NesGameDev-Parser.o NesGameDev-ProgramROM.lst NesGameDev-ProgramROM.bin 32768 0 32768 0 ;
./NesGameDev-Converter.o NesGameDev-PatternTable0.bmp NesGameDev-PatternTable1.bmp NesGameDev-CharacterROM.bin ;
./NesGameDev-Combiner.o NesGameDev-ProgramROM.bin NesGameDev-CharacterROM.bin GAME.NES ;
./PICnes.o GAME.NES ;
