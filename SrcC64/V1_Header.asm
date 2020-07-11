	ifdef  BuildC64_CRT
; cartridge code appears at $8000
;*=$8000
;        byte    $09, $80, $25, $80, $c3, $c2, $cd, $38, $30, $8e, $16, $d0, $20, $a3, $fd, $20
        ;byte    $50, $fd, $20, $15, $fd, $20, $5b, $ff, $58, $ea, $ea, $ea, $ea, $ea, $ea, $ea
        ;byte    $ea, $ea, $ea, $ea, $ea
;*=$8025



   ;******************************
   ; CRT Header ($40)
   ;******************************

   ; CRT format cartridge header
   org $7FB0						  
   byte "C64 CARTRIDGE   "	   		; Cartridge Signature
   byte $00,$00,$00,$40			   	; Header length $00000040
   byte $01,$00					    ; Version (1.00)
   byte $00,$00 				 	; Cartridge Type... $0000 = normal
   byte $00						   	; Exrom Status... $00 = none
   byte $00 					   	; Game Line Status... $00 = none
   byte $00,$00,$00,$00,$00,$00    	; Unused
   ;     12345678901234567890123456789012
   byte "CYNTHCART                       "	; 32 byte cartridge name

   ;******************************
   ; Chip Packet Header ($10)
   ;******************************

   org $7FF0
   byte "CHIP"
   byte $00, $00, $40, $10	; Chip Packet Length $00002010
   byte $00, $00			; Chip type 0 = ROM, 1 = RAM
   byte $00, $00			; Bank Location $0000 = normal cartridge
   byte $80, $00			; Load location $8000
   byte $40, $00			; Rom image size $2000

   org $8000				;Start of ROM
   
   word Startup; Startup Vector
   word Startup; Restore Vector
   byte $C3, $C2, $CD, $38, $30	

Startup:
   sei

   jsr $FF84		;IOINIT. Initialize CIA's, SID volume; setup memory configuration; set and start interrupt timer.
   jsr $FF87		;RAMTAS. Clear memory addresses $0002-$0101 and $0200-$03FF; run memory test and set start 
						;and end address of BASIC work area accordingly; set screen memory to $0400 and datasette buffer to $033C.
   jsr $FF8A		;RESTOR. Fill vector table at memory addresses $0314-$0333 with default values.
   jsr $FF81		;SCINIT. Initialize VIC; restore default input/output to keyboard/screen; clear screen; set PAL/NTSC switch and interrupt timer.

   cli

	else
*=$0801

        ;BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00 ;Start at $1000
;		BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00  ;Start at $0900
        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $36, $34, $29, $00, $00, $00  ;Start at $0810

*=$0810
	endif

z_Regs 		equ $20			;Fake Registers
Cursor_X 	equ $40
Cursor_Y 	equ Cursor_X+1
SPpage 		equ $0100