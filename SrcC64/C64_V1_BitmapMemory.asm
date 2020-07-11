;Color Ram  11011000 - 11011011
;Color Regs 00000100 - 00000111

;BG $D020
;Border $D021

GetColMemPos:
	
	
	lda #0
	sta z_d
	sta z_h
	txa
	sta z_e

	tya
	and #%11111000
	
	tax ;sta z_c
		;jsr AddDE_BC
		;clc
		;lda z_c
		adc z_e
		sta z_e
		lda z_h
		
		adc z_d
		sta z_d
	
	txa ;lda z_c
	rol
	rol z_h
	rol
	rol z_h
	
	ifdef ScrWid256
		adc #$04
	endif
	
		adc z_e
		sta z_e
		lda z_h
		adc #$04	;Screen Offset
		adc z_d
		sta z_d
	
	;clc
	;ror
	;ror
	;ror
	;cmp #0
	;beq GetScreenPosC_NoY
	;tay
;GetScreenPosC_Yagain;
;	jsr AddDE_BC
;	dey
;	bne GetScreenPosC_Yagain
;GetScreenPosC_NoY
	
	
	
;	pullpair z_bc
	
	rts



GetScreenPos:
	
	pushpair z_bc
	
	
	lda #0
	sta z_d
	txa
	;sta ;z_e
	clc
	rol ;z_e
	rol z_d
	rol ;z_e
	rol z_d
	rol ;z_e
	rol z_d
	ifdef FourColor
		;rol z_e
		rol z_d
	endif
	sta z_e
	
	
;	lda #$01
;	sta z_b
;	lda #$40
;	sta z_c
;	
	lda #0
	sta z_b
	tya
	and #%11111000
	clc
	rol
	rol z_b
	rol
	rol z_b
	rol
	rol z_b
	tax ;sta z_c
		;jsr AddDE_BC
		;clc
		;lda z_c
		adc z_e
		sta z_e
		lda z_b
		
		adc z_d
		sta z_d
	
	txa ;lda z_c
	rol
	rol z_b
	rol
	rol z_b
	;sta z_c
		;jsr AddDE_BC
		;clc
		;lda z_c
		adc z_e
		sta z_e
		lda z_b
		
		adc z_d
		sta z_d
	
;	cmp #0
	;beq GetScreenPos_NoY
;	tay
;GetScreenPos_Yagain
	;jsr AddDE_BC
	;dey
;	bne GetScreenPos_Yagain
;GetScreenPos_NoY
	
	lda #$20	;Screen Offset
	sta z_b
	ifdef ScrWid256
		lda #$04*8
	else
		lda #$00
	endif
	
	sta z_c
	jsr AddDE_BC

	
	pullpair z_bc
	
	rts
	
GetNextLine:
	rts
		 pushpair z_bc
			 lda #$00
			 sta z_b
			 lda #40
			 sta z_c
			 jsr AddDE_BC
		 pullpair z_bc
	rts