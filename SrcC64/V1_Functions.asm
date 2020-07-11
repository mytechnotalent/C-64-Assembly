
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ScreenInit:


		lda $D011
        and #%10011111
        ora #%00100000
        sta $D011

        lda $D016              
        and #%11101111 
	ifndef Mode2Color
        ora #%00010000  ;1=Multicolor 4 color ;0=standard 2 color        
	endif
        sta $D016


        lda $D018
        and #%11110111
        ora #%00001000  ;1=Screen at %2000 (Other bits have no function in bitmap mode)
        sta $D018
		
	
	
	

	
	; lda #<$D800
	; sta z_E
	; lda #>$D800
	; sta z_D
	
	; lda #<($DBE7-$D800)
	; sta z_C
	; lda #>($DBE7-$D800)
	; sta z_B
	
	; ldx #0
; FillNextScrA:
	; lda #$0F
	; sta (z_de,x)
	; jsr DecBC
	; jsr IncDE
	; lda z_b
	; ora z_c
	; bne FillNextScrA

	
	

	
	; lda #<$0400
	; sta z_E
	; lda #>$0400
	; sta z_D
	
	; lda #<($07E7-$0400)
	; sta z_C
	; lda #>($07E7-$0400)
	; sta z_B
	
	; ldx #0
; FillNextScrB:
	; lda #$EC
	; sta (z_de,x)
	; jsr DecBC
	; jsr IncDE
	; lda z_b
	; ora z_c
	; bne FillNextScrB

	
	rts
PrintChar:

	clc
	sbc #31
	
	
	
	;lda #$8		;Char length
	sta z_C
	lda #$0
	sta z_B
	
	PushAll
	lda z_h
	pha
	lda z_l
	pha
	
	
	clc
	rol z_C
	rol z_B
	rol z_C
	rol z_B
	rol z_C
	rol z_B
	
	
	lda #<BitmapFont
	sta z_L
	lda #>BitmapFont
	sta z_H
	
	
	
	jsr addhl_bc;Select char
	
	
	
	
	

	
	lda #0
	sta z_d
	lda Cursor_X
	ifdef ScrWid256
		clc
		adc #4
	endif
	sta z_e
	clc
	rol z_e
	rol z_d
	rol z_e
	rol z_d
	rol z_e
	rol z_d
	ifndef Mode2Color
	ifndef HalfWidthFont
		rol z_e
		rol z_d
	endif
	endif
	
	lda #$01
	sta z_b
	lda #$40
	sta z_c
;	
	lda Cursor_Y;
	cmp #0
	beq PrintChar_NoY
	tay
PrintChar_Yagain;
	jsr AddDE_BC
	dey
	bne PrintChar_Yagain
PrintChar_NoY
	
	lda #$20	;Screen Offset
	sta z_b
	lda #$00
	sta z_c
	jsr AddDE_BC

	;ldx #0
	ldy #0
PrintChar_Loop
	ifndef Mode2Color
		lda #0
		sta z_as
	endif 
	lda (z_HL),y
	ifndef Mode2Color
	ifndef HalfWidthFont
		clc
		rol 
		rol z_as
		rol z_as
		rol 
		rol z_as
		rol z_as
		rol 
		rol z_as
		rol z_as
		rol 
		rol z_as
		;rol z_as
		
		lda z_as
		rol
		ora z_as
	endif
	endif 
    sta (z_DE),y
		
	;jsr IncHL
	;jsr IncDE
	iny
	;dey 
	tya
	cmp #8
	bne PrintChar_Loop
		
	ifndef Mode2Color
	ifndef HalfWidthFont
		lda #0
		sta z_b
		lda #8
		sta z_c
		jsr AddDE_BC
	
	
		;ldx #0
		ldy #0
PrintChar_Loop2:
		
		lda #0
		sta z_as
		lda (z_HL),Y

			clc
			ror 
			ror z_as
			ror z_as
			ror 
			ror z_as
			ror z_as
			ror 
			ror z_as
			ror z_as
			ror 
			ror z_as
			;rol z_as
			
			lda z_as
			ror
			ora z_as
		sta (z_DE),Y
			
		;jsr IncHL
		;jsr IncDE

		iny
		;dey 
		tya
		cmp #8
		bne PrintChar_Loop2
	endif
	endif
	
	inc Cursor_X
	lda Cursor_X
	ifndef Mode2Color
		ifndef HalfWidthFont
			cmp #20
		else
			cmp #40
		endif
	else
		cmp #40
	endif
	bne PrintChar_NotNextLine
	jsr NewLine
	
	;lda #0
	;sta Cursor_X
	;inc Cursor_Y
PrintChar_NotNextLine:
	
	
	pla
	sta z_l
	pla
	sta z_h	
	PullAll
	
	rts

Locate:
	stx Cursor_X 
	sty Cursor_Y
	rts
	
NewLine:
	lda #0
	sta Cursor_X	
	inc Cursor_Y
	rts
	
	
Cls:
	lda #$00
		sta z_L
		
		lda #$04
		sta z_H
		
		
		lda #$EF
		sta z_C
		
		lda #$03
		sta z_B
		
		lda #$2E
		
		jsr CLDIR
		
	ifndef Mode2Color		
		lda #$00
		sta z_L
		
		lda #$D8
		sta z_H
		
				
		lda #$EF
		sta z_C
		
		lda #$03
		sta z_B
		
		lda #$07
		
		jsr CLDIR
		
	endif

		loadpair z_hl,$2000
		loadpair z_bc,($2000-1)
		
		lda #0
		jmp cLdir
	
		
				
		ldx #0
		ldy #0
		jsr Locate
        rts