	include "./SrcAll/V1_Header.asm"		;Cartridge/Program header - platform specific
	include "./SrcAll/BasicMacros.asm"		;Basic macros for ASM tasks

	SEI						;Stop interrupts
	jsr ScreenInit					;Init the graphics screen
	jsr Cls						;Clear the screen
		
;Example 1
	;lda #$79					;Load hex 69 into A
	;jsr monitor 					;Show registers to screen
	;jmp *						;Infinite Loop
	
	
;Example 2	
	;lda #$69					;Load A with Hex $69
	;ldx #69					;Load A with Decimal 69
	;ldy 69						;Load A from memory address 0069
	;jsr monitor					;Show the monitor
	;jmp *						;Infinite Loop

	
;Example 3
	; lda #$15					;Set A to Hexa
	; jsr monitor					;Show the monitor
	; clc						;Clear the carry (need to do this before ADC to simulate ADD)
	; adc #1					;ADD decimal 1 with carry
	; jsr monitor					;Show the monitor
	; sec						;Set the carry (need to do this before SBC to simulate SUB)
	; sbc #1					;Subtract Decimal 1 with the carry
	; jsr monitor					;Show the monitor
	; jmp *						;Infinite Loop
	
	
;Example 4
	;lda #$25					;Set A to $25
	;ldy #$34					;Set Y to $34
	;jsr monitor					;Show the monitor
	;tax						;Transfer A to X
	;tya						;Transfer Y to A
	;jsr monitor					;Show the monitor
	;jmp *						;Infinite Loop

;Example 4	
    jsr MemDump						;Dump an address to screen
		dw $0000      				;Address to show
		db $3          				;Lines to show

	lda #$1						;Load A with Hex 11
	sta $0000					;Save to memory address $0011
	lda #$22					;Load A with Hex 22
	sta $0012					;Save to memory address $0022
	
	lda #$33					;Load A with Hex 33
	clc						;Clear the carry (we don't want to add it!)
	adc $0011					;Add the value at address $0011
	adc $0012					;Add the value at address $0012
	sta $0013					;Store the result to address $0013
	
    jsr MemDump						;Dump an address to screen
	    dw $0000      				;Address to show
		db $3          				;Lines to show
	
	jmp *						;Infinite Loop
	
;	;Why not try: Try changing CLC->SEC and ADC->SBC!
	
	include "./SrcAll/monitor.asm"			;Debugging tools
	include "./SrcAll/BasicFunctions.asm"		;Basic commands for ASM tasks
	
Bitmapfont:						;Chibiakumas bitmap font
	ifndef BuildVIC
		incbin "./ResAll/Font64.FNT"		;Not used by the VIC due to memory limitations
	endif
	

	include "./SrcAll/V1_Functions.asm"		;Basic text to screen functions
	include "./SrcAll/V1_BitmapMemory.asm"		;Bitmap functions for Bitmap screen systems
	include "./SrcAll/V1_VdpMemory.asm"		;VRAM functions for Tilemap Systems
	include "./SrcAll/V1_Palette.asm"		;Palette functions
	include "./SrcAll/V1_Footer.asm"		;Footer for systems that need it
	
