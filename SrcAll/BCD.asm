
BCD_Show:
	ldy #0
BCD_ShowDirect:
	tya
	pha
		pushpair z_de
		lda (z_de),y
		jsr PrintBCDChar		
		pullpair z_de
	pla
	tay
	iny
	dex
	bne BCD_ShowDirect
	rts
	
BCD_Add:
	txa
	tay
	dey
	php
		sed	;Set Decimal
		clc
BCD_Add_Again:
		lda (z_de),y
		adc (z_hl),y
		ifdef BuildNES
			jsr NesBCD_ADC
		endif
		sta (z_de),y
		dex
		beq BCD_Add_Done
		dey
		jmp BCD_Add_Again
BCD_Add_Done:
	plp
	rts
	
BCD_Subtract:
	txa
	tay
	dey
	php
		sed	;Set Decimal
		sec
BCD_Subtract_Again:
		lda (z_de),y	
		sbc (z_hl),y
		ifdef BuildNES
			jsr NesBCD_SBC
		endif
		sta (z_de),y
		dex
		beq BCD_Subtract_Done
		dey
		jmp BCD_Subtract_Again
BCD_Subtract_Done:
	plp
	rts
	
PrintBCDChar:
	pha
		and #$F0
		jsr SwapNibbles
		jsr PrintBCDCharOne	
	pla
	and #$0F
PrintBCDCharOne:	
	clc
	adc #'0'
	jmp PrintChar
	
	

BCD_Cp:
	txa
	tay
	dey
		sed	;Set Decimal
		
BCD_Cp_Again:
		lda (z_hl),y	
		cmp (z_de),y
		bne BCD_Cp_Done
		dex
		beq BCD_Cp_Done
		dey
		jmp BCD_Cp_Again
BCD_Cp_Done:
		cld ;decimal off
	rts
	
	ifdef BuildNES
NesBCD_ADC:		;Nes has no BCD, so make some fixup routines
	pha
		and #$0F
		cmp #$0A
		bcc NesBCD_ADC_NoOverflow
	pla	
		sec
		sbc #$0A
		clc
		adc #$10
	pha
NesBCD_ADC_NoOverflow:
	pla
	pha
		and #$F0
		cmp #$A0
		bcc NesBCD_ADC_NoOverflow2
	pla
	sec
	sbc #$A0
	sec
	rts
NesBCD_ADC_NoOverflow2:
	clc
	pla
	rts
	
	
NesBCD_SBC:		;Nes has no BCD, so make some fixup routines
	pha
		and #$0F
		cmp #$0A
		bcc NesBCD_SBC_NoOverflow
	pla	
		sec
		sbc #$06
		;sec
		;sbc #$10
	pha
NesBCD_SBC_NoOverflow:
	pla
	pha
		and #$F0
		cmp #$A0
		bcc NesBCD_SBC_NoOverflow2
	pla
	sec
	sbc #$60
	clc
	rts
NesBCD_SBC_NoOverflow2:
	sec
	pla
	rts
	endif
	
