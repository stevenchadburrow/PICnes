# PICnes
<b>A fast NES Emulator written in C specifically for microcontrollers.</b><br>

Inspired by Mahyar Koshkouei's <a href="https://github.com/deltabeard/Peanut-GB">Peanut-GB (with MiniGB-APU)</a>, I designed my own NES emulator compariable to his Gameboy emulator.  This project is the result of a few months of very dedicated programming, then small updates and changes when necessary.  The goal of PICnes was to run on the PIC32MZ microcontroller at 260 MHz with only 512KB of RAM and 2MB of ROM.<br>

<b>Features:</b><br>
- Everything is inside of a single C file.  Nothing complicated about it.  Easy to port!<br>
- Specific functions for video, audio, and buttons making it easy to change to your specific needs.<br>
- Uses OpenGL/GLFW and OpenAL for video, keyboard, and audio for an open platform to start from.<br>
- Works with most games, including mappers: NROM, UNROM, CNROM, ANROM, MMC1, and MMC3 (mostly implemented).<br>
- Very fast!  Runs games on a PIC32MZ microcontroller at 45 FPS with only a few exceptions.<br>
- Public domain, free for all to use!<br>

<b>Known Issues:</b><br>
- Megaman 3, Megaman 4, and Ninja Gaiden 2 will not start unless the V-Sync Hack is turned on, but it can then be turned off later.<br>
- Super Mario Bros 3 sprite priority is wrong, the Sprite Priority Hack helps a little bit.<br>
- Audio quality from OpenAL is terrible, but it is at least proof-of-concept to port to other platforms.<br>

<b>Links:</b><br>
- For the first version of this emulator, and large list of working ROMs, go here: <a href="https://github.com/stevenchadburrow/AcolyteHandPICd32/tree/main/NES">AcolyteHandPICd32/NES</a>.<br>
- For my last PIC32MZ microcontroller project that uses this emulator, go here: <a href="https://github.com/stevenchadburrow/AcolyteHandheld">AcolyteHandheld</a>.<br>
- For my Raspberry Pi Zero 2W project that uses this emulator, go here: <a href="https://github.com/stevenchadburrow/RPi02W-Emulators">RPi02W-Emulators</a>.<br>
- For the #1 guide to NES programming, go here: <a href="https://www.nesdev.org/wiki/Nesdev_Wiki">NESdev Wiki</a>.<br>

<b>Images:</b><br>
<table>
<tr><td><img src="Images/PICnesImages-SuperMarioBros.png"></td>
  <td><img src="Images/PICnesImages-SuperMarioBros3.png"></td></tr>
<tr><td><img src="Images/PICnesImages-LegendOfZelda.png"></td>
  <td><img src="Images/PICnesImages-KirbysAdventure.png"></td></tr>
<tr><td><img src="Images/PICnesImages-Metroid.png"></td>
  <td><img src="Images/PICnesImages-RadRacer.png"></td></tr>
<tr><td><img src="Images/PICnesImages-MicroMages.png"></td>
  <td><img src="Images/PICnesImages-AlwasAwakening.png"></td></tr>
</table>


