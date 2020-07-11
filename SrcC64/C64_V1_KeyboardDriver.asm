
Read_Keyboard
KeyboardScanner_Read:

	lda #<KeyboardScanner_KeyPresses
	sta z_L
	lda #>KeyboardScanner_KeyPresses
	sta z_H
	
	ldy #0
	lda #%11111110
	sta z_as
NextRow:
	lda z_as
	sta $DC00
	lda $DC01
	sta (z_HL),y
	iny
	sec
	rol z_as
	tya
	cmp #8
	bcc NextRow
	
	
	lda #%01111111		;Joy 1
	sta $DC00
	lda $DC01
	sta (z_HL),y
	iny
	lda #%10111111		;Joy 2
	sta $DC00
	lda $DC00
	sta (z_HL),y
	;iny

	ldx #0
	ldy #0
	jsr Locate
	ldy #0
MextRow2
	lda (z_HL),y
	jsr PrintHex
	iny
	tya
	cmp #10
	bcc MextRow2
	rts


HardwareKeyMap:		

    db "d", "5", "3", "1", "7", "r", 13 ,  9
    db "s", "E", "S", "Z", "4", "A", "W", "3"
    db "X", "T", "F", "C", "6", "D", "R", "5"
    db "V", "U", "H", "B", "8", "G", "Y", "7"
    db "N", "O", "K", "M", "0", "J", "I", "9"
    db ",", "@", ":", ".", "-", "L", "P", "+"
    db "/", "^", "=", "s", "h", ";", "*", "#"
    db "r", "Q", "c", " ", "2", "t", "a", "1"		
