
z_HL equ z_Regs
z_L  equ z_Regs
z_H  equ z_Regs+1

z_BC equ z_Regs+2
z_C  equ z_Regs+2
z_B  equ z_Regs+3

z_DE equ z_Regs+4
z_E  equ z_Regs+4
z_D  equ z_Regs+5

z_As equ z_Regs+6
z_Hs equ z_Regs+7

z_ixl equ z_Regs+8
z_ixh equ z_Regs+9
z_ix equ z_Regs+8


z_iyl equ z_Regs+10
z_iyh equ z_Regs+11
z_iy  equ z_Regs+10

z_spec equ z_Regs+12 ; Used for A during Z80 emu routines


t_SP     	equ z_Regs+8
t_RetAddr 	equ z_Regs+9
t_RetAddrL 	equ z_Regs+9
t_RetAddrH 	equ z_Regs+10
t_A     	equ z_Regs+11
t_X     	equ z_Regs+12
t_Y     	equ z_Regs+13

t_MemdumpL     	equ z_Regs+14
t_MemdumpH     	equ z_Regs+15

t_MemdumpBL     	equ z_Regs+16
t_MemdumpBH     	equ z_Regs+17

;z_BCs equ z_Regs+18
;z_Cs  equ z_Regs+19
;z_Bs  equ z_Regs+20

Bit0 equ	LookupBits+0
Bit1 equ	LookupBits+1
Bit2 equ	LookupBits+2
Bit3 equ	LookupBits+3
Bit4 equ	LookupBits+4
Bit5 equ	LookupBits+5
Bit6 equ	LookupBits+6
Bit7 equ	LookupBits+7

LookupBits: 		db %00000001,%00000010,%00000100,%00001000,%00010000,%00100000,%01000000,%10000000
LookupMaskBits: 	db %11111110,%11111101,%11111011,%11110111,%11101111,%11011111,%10111111,%01111111
printhex:
        pha
                clc
                and #%11110000
                ror
                ror
                ror
                ror
                jsr printhexAgain
        pla
        pha
                and #%00001111
                jsr printhexAgain
        pla
        rts
printhexAgain
        cmp #10
        bcs printhex_OverNine
        clc
        adc #'0'
        jsr PrintChar
        rts
printhex_OverNine
        clc
        adc #55
        ;'adc #'A'
        jsr PrintChar
        rts

    

PrintString
        ldy #0
PrintString_again
        lda (z_HL),y
        cmp #255
        beq PrintString_Done
        jsr PrintChar
        iny
        jmp PrintString_again
PrintString_Done
        rts

WaitChar
        tya
        pha

WaitChar_Again
        jsr $FFE4       ;ReadChar
        beq WaitChar_Again

        sta t_A
        pla
        tay
        lda t_A
        rts

SwapXY
        pha
        txa
        pha
        tya

        tax
        pla
        tay
        pla
        
        rts

;NewLine
        ;lda #13
        ;jmp $FFD2       ;PrintChar


;Locate
        ;jsr SwapXY
        ;clc
        ;jsr $E50A
        ;rts

GetPos
        
        sec     ;set carry
        jsr $E50A
        jsr SwapXY
        rts
		
CLDIR:	;Clear LDIR
		ldy #0
		sta (z_hl),y
		lda z_l
		clc
		adc #1
		sta z_e
		lda #0
		adc z_h
		sta z_d
		
LDIR:
;        jsr MemDump
;        word z_HL	      ;Address
;        byte $1          ;Lines
			
		ldy #0
        lda (z_HL),Y
        sta (z_DE),Y
	
		INC z_L
		BNE	LDIR_SkipInc1
		INC	z_H
LDIR_SkipInc1:
		INC z_E
		BNE	LDIR_SkipInc2
		INC	z_D
LDIR_SkipInc2:

		DEC z_C
		BNE LDIR
		LDA z_B
		BEQ	LDIR_Done
		DEC z_B
		jmp LDIR
LDIR_Done:
		rts
IncBC:
		INC z_C
		BNE	IncBC_Done
		INC	z_B
IncBC_Done:
		rts
		
IncDE:
		INC z_E
		BNE	IncDE_Done
		INC	z_D
IncDE_Done:
		rts
		
IncHL:
		INC z_L
		BNE	IncHL_Done
		INC	z_H
IncHL_Done:
		rts
				
DecBC:	
	pha
		lda z_C
		bne DecBC_b
		DEC z_B
DecBC_b:	
		DEC z_C
	pla
	rts
				
DecHL:		
	pha
		lda z_L
		bne DecHL_h
		DEC z_H
DecHL_h:	
		DEC z_L
	pla
	rts
	
DecDE:		
	pha
		lda z_E
		bne DecDE_D
		DEC z_D
DecDE_D:	
		DEC z_E
	pla
	rts
AddHL_DE				;Add DE to HL
		clc
		lda z_e			;Add E to L
		adc z_l
		sta z_l
		lda z_d			;Add D to H (with any carry)
		adc z_h
		sta z_h
		rts
		
AddHL_0C:		
		lda #0
		sta z_b
AddHL_BC				;Add BC to HL
		clc
		lda z_c
		adc z_l
		sta z_l
		lda z_b
		adc z_h
		sta z_h
		rts
SubHL_BC				;Subtract BC to HL
		sec
		lda z_l
		sbc z_c
		sta z_l
		lda z_h
		sbc z_b
		sta z_h
		rts
SubHL_DE				;Subtract BC to HL
		sec
		lda z_l		;Subract E from L
		sbc z_E
		sta z_l
		lda z_h		;Subtract D from H (with any carry)
		sbc z_D
		sta z_h
		rts
AddDE_BC				;Add DE to HL
		clc
		lda z_c
		adc z_e
		sta z_e
		lda z_b
		
		adc z_d
		sta z_d
		rts
SwapNibbles				;$AB -> $BA
		ASL ;(shift left - bottom bit zero)
		ADC #$80 ;(pop top bit off)
		ROL ;(shift carry in)
		ASL ;(shift left - bottom bit zero)
		ADC #$80 ;(pop top bit off)
		ROL ;(shift carry in)
		rts