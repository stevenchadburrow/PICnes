./asm6/asm6.o NesGameDev-Code.asm NesGameDev-ProgramROM.bin ;
./NesGameDev-Converter.o NesGameDev-PatternTable0.bmp NesGameDev-PatternTable1.bmp NesGameDev-CharacterROM.bin ;
./NesGameDev-Combiner.o NesGameDev-ProgramROM.bin NesGameDev-CharacterROM.bin GAME.NES ;
./PICnes.o GAME.NES ;
