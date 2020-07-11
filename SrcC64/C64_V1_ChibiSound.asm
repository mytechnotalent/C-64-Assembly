ChibiSound_Silent:
	;lda #%00000000
	;sta $4015		;4015h - DMC/IRQ/length counter status/channel enable register	
	;ora #%00000000
	sta $D418			;$D418	Volume and filter modes.	MHBLVVVV	Mute3 / Highpass / Bandpass / Lowpass / Volume (0=silent)
	rts
ChibiSound:
	ora #0
	beq ChibiSound_Silent
	pha
	lda #255
	sta $D400			;$D400	Voice #1 frequency. W	LLLLLLLL	
	pla 
	pha
		and #%00111111
		;lda #64
		sta $D401		;$D401	Voice #1 frequency. W	----HHHH	Higher values=higher pitch
		lda #0
		sta $D402		;$D402	Voice #1 pulse width. W	LLLLLLLL 	
		lda #%00001111
		sta $D403		;$D403	Voice #1 pulse width. W	----HHHH	
	pla
	pha
		and #%10000000
		beq ChibiSound_NoNoise
		lda #%10000001
		jmp ChibiSound_NoiseDone
ChibiSound_NoNoise:
		lda #%01000001
ChibiSound_NoiseDone:
		sta $D404		;$D404	Voice #1 control register.	NPST-RSG	Noise / Pulse / Sawtooth / Triangle / - test / Ring mod / Sync /Gate
		lda #%00000000
		sta $D405		;$D405	Voice #1 Attack and Decay length. 	AAAADDDD	Atack / Decay
		lda #%11001000
		sta $D406		;$D406	Voice #1 Sustain volume and Release length.	SSSSRRRR	Sustain  / Release
	pla
	and #%01000000
	clc
	ror
	ror
	ror
	ora #%00000111
	sta $D418			;$D418	Volume and filter modes.	MHBLVVVV	Mute3 / Highpass / Bandpass / Lowpass / Volume (0=silent)
	

	rts
	
	








