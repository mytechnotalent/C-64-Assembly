
SetHardwareSprite:
		tay		;Sprite Number
		lda $D015
		ora LookupBits,y
		sta $D015			;Sprite on
		
		lda #%00010000
		jsr C64SpriteConvertToMask
		jsr monitor
		lda $D01C
		ora z_as
		sta $D01C			;4 color
		
		lda #%00100000
		jsr C64SpriteConvertToMask
		lda $D017
		ora z_as
		sta $D017			;DoubleHeight
		
		
		lda #%01000000
		jsr C64SpriteConvertToMask
		lda $D01D
		ora z_as
		sta $D01D			;DoubleWidth
		
		
		; sta $D01D		;Double Width
		; sta $D017		;Double height
		
		
		lda z_h
		sta $07F8,y			;Pointer
		
		lda z_l
		and #%00001111
		sta $D027,y			;Color
		
		
		lda #%00000001
		and z_ixh
		jsr C64SpriteConvertToMaskB
		lda $D010
		ora z_as
		sta $D010 		;8th bit of X

		
		
		tya			;Double Y
		asl
		tay
		
		lda z_ixl
		sta $D000,y		;X
				
		lda z_iyl
		sta $D001,y		;Y
		 
		rts
		 
C64SpriteConvertToMask:
		and z_l
C64SpriteConvertToMaskB:
		beq C64SpriteConvertToMaskZero 
		lda LookupBits,y
		
		jmp C64SpriteConvertToMaskDone
C64SpriteConvertToMaskZero:
		lda #0
C64SpriteConvertToMaskDone:
		sta z_as
		rts