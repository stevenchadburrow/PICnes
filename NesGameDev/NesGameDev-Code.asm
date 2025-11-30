
; This setup is designed to create NES games, primarily using Linux
; The following code and images to show a simple 'Hello World' program
; Demonstrates Background, Sprites, and Controller Input 


; NesGameDev-Code.asm

; To compile
; ./asm6/asm6.o NesGameDev-Code.asm NesGameDev-ProgramROM.bin

; To convert
; ./NesGameDev-Converter.o NesGameDev-PatternTable0.bmp NesGameDev-PatternTable1.bmp NesGameDev-CharacterROM.bin

; To combine
; ./NesGameDev-Combiner.o NesGameDev-ProgramROM.bin NesGameDev-CharacterROM.bin GAME.NES

; To simulate
; ./PICnes.o GAME.NES


; variables

vblank_ready .EQU $00 ; used for detecting if v-sync has occured
button_status .EQU $01 ; stores the value of the buttons
sprite_x .EQU $02 ; x-coord of sprite on screen
sprite_y .EQU $04 ; y-coord of sprite on screen

oam_page .EQU $0200 ; page where oam data exists, transferred by dma

ppu_ctrl .EQU $2000
ppu_mask .EQU $2001
ppu_status .EQU $2002
ppu_scroll .EQU $2005
ppu_addr .EQU $2006
ppu_data .EQU $2007

oam_dma .EQU $4014
snd_chn .EQU $4015
joy_one .EQU $4016
joy_two .EQU $4017

; code

	.ORG $8000

reset

; disable irq and decimal mode
	SEI
	CLD

; set stack pointer
	LDX #$FF
	TXS

; disable ppu and nmi
	LDA #$00
	STA ppu_ctrl
	STA ppu_mask

; disable audio
	LDA #$00
	STA snd_chn

; wait for v-sync twice
	BIT ppu_status
wait_one
	BIT ppu_status
	BPL wait_one
wait_two
	BIT ppu_status
	BPL wait_two
	

; clear w reg
	LDA ppu_status

; set ppu to palette addr
	LDA #$3F
	STA ppu_addr
	LDA #$00
	STA ppu_addr

; blue for background
	LDA #$0F
	STA ppu_data
	LDA #$01
	STA ppu_data
	LDA #$11
	STA ppu_data
	LDA #$21
	STA ppu_data
	LDX #$0C
	LDA #$0F ; black for rest
palette_one
	STA ppu_data
	DEX
	BNE palette_one

; orange for sprites
	LDA #$0F
	STA ppu_data
	LDA #$07
	STA ppu_data
	LDA #$17
	STA ppu_data
	LDA #$27
	STA ppu_data
	LDX #$0C
	LDA #$0F ; black for rest
palette_two
	STA ppu_data
	DEX
	BNE palette_two

; set oam/sprite y-coords
	LDX #$00
	LDA #$EF ; not drawn
loop_sprites
	STA oam_page,X
	INX
	INX
	INX
	INX
	BNE loop_sprites

; oam/sprite dma
	LDA #$02
	STA oam_dma

; clear w reg
	LDA ppu_status

; load name_table (and attribute_table)
	LDA #$20
	STA ppu_addr
	LDA #$00
	STA ppu_addr
	LDX #$00
	LDY #$04
	LDA #$00 ; use tile $00
loop_background
	STA ppu_data
	INX
	BNE loop_background
	DEY 
	BNE loop_background

; setup sprite info
	LDA #$1F
	STA sprite_x
	STA sprite_y

; enable sprites and background
	LDA #$1E ; enable sprites and background
	STA ppu_mask

; clear w reg
	LDA ppu_status

; setup ppu and nmi
	LDA #$00 ; top-left corner is at $0000
	STA ppu_scroll
	STA ppu_scroll
	LDA #$90 ; turn on nmi, sprites uses $0000, background uses $1000
	STA ppu_ctrl

; clear v-blank flag
	LDA #$00
	STA vblank_ready

; wait for v-blank flag to be set
inf
	LDA vblank_ready
	BEQ inf

; clear v-blank flag
	LDA #$00
	STA vblank_ready

; clear w reg
	LDA ppu_status

; setup ppu
	LDA #$00 ; top-left corner is at $0000
	STA ppu_scroll
	STA ppu_scroll
	LDA #$90 ; turn on nmi, sprites uses $0000, background uses $1000
	STA ppu_ctrl

; latch controller
	LDA #$01
	STA joy_one
	LDA #$00
	STA joy_one

; read controller (backwards)
	LDA #$00
	STA button_status
	LDX #$08
controller
	ASL button_status
	LDA joy_one
	AND #$01
	ORA button_status
	STA button_status
	DEX
	BNE controller

; move sprite according to buttons
	LDA button_status
	AND #$01 ; d-pad right
	BEQ skip_right
	INC sprite_x ; go right
skip_right
	LDA button_status
	AND #$02 ; d-pad left
	BEQ skip_left
	DEC sprite_x ; go left
skip_left
	LDA button_status
	AND #$04 ; d-pad down
	BEQ skip_down
	INC sprite_y ; go down
skip_down
	LDA button_status
	AND #$08 ; d-pad up
	BEQ skip_up
	DEC sprite_y ; go up
skip_up

; redraw sprite 0
sprite
	LDA sprite_y ; y-coord
	STA oam_page+0
	LDA #$00 ; use tile 0
	STA oam_page+1
	LDA #$00 ; use palette 4
	STA oam_page+2
	LDA sprite_x ; x-coord
	STA oam_page+3

; oam/sprite dma
	LDA #$02
	STA oam_dma

; jump back to loop
	JMP inf


nmi
	INC vblank_ready ; set v-blank flag
	RTI ; return
	
irq
	RTI ; return

; vectors

	.ORG $FFFA
	.WORD nmi
	.WORD reset
	.WORD irq


