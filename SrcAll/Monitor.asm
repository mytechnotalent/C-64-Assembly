;Usage:
;        jsr MemDump
;        word $CEED      ;Address
;        byte $3          ;Lines



MemDump

        pha
        txa
        pha
        tya
        pha
        tay
                ;jsr Monitor
                tsx
              
                ;jsr Monitor
                
                lda SPpage+$04,x
                sta t_RetAddrL
                ;jsr Monitor
                lda SPpage+$05,x
                sta t_RetAddrH
                ;jsr Monitor

                ldy #1
                lda (t_RetAddr),Y
                sta t_MemdumpL
                ;jsr Monitor
        
                iny
                lda (t_RetAddr),Y
                sta t_MemdumpH
                ;jsr Monitor
        
                iny
                lda (t_RetAddr),Y
                
                tax  
                jsr MemDumpDirectB

                tsx
                inc SPpage+$04,x
                inc SPpage+$04,x
                inc SPpage+$04,x
				
				
                lda SPpage+$04,x
                cmp #3
                bcs MemDump_NoIncSpH
				inc SPpage+$05,x
MemDump_NoIncSpH
        pla
		tay
        pla
        tax
        pla

		
        rts

MemDumpDirect
        ldy #8
MemDumpDirectB
        lda t_MemdumpH
        sta t_MemdumpBH
        jsr printhex
        lda t_MemdumpL
        sta t_MemdumpBL
        jsr printhex

        lda #":"
        jsr PrintChar
        jsr NewLine

        ldy #0
MemDump_Again
		;jsr Monitor

        tya
        pha
MemDump_AgainHex
                lda (t_MemdumpL),y

                jsr printhex
                lda #" "
                jsr PrintChar
                iny
                tya
                and #%00000111
                bne MemDump_AgainHex
        pla
        tay
MemDump_AgainChar
        lda (t_MemdumpBL),y
        cmp #32
        Bcc MemDump_BadChar
        cmp #128
        Bcs MemDump_BadChar
MemDump_AgainCharRet
        
        jsr PrintChar

        iny
        tya
        and #%00000111
        bne MemDump_AgainChar
		ifndef BuildNES
		ifndef BuildPCE
			jsr NewLine
		endif
		endif
MemDump_CarryOn
		
        dex
        bne MemDump_Again
			
        rts
MemDump_BadChar
        lda #"."
        jmp MemDump_AgainCharRet
		
		
		
Monitor
        ;lda #$69
        ;pha
        ;plp

        php
        pha
                lda #"a"
                jsr printmonitorchar
        pla
        pha     ;Push A
        jsr printmonitorhex
        

        txa     ;ld a,x69696
        pha     ;push

        tya     ;ld a,y
        pha     ;push

      ;  tsx     ;LD X,SP
    
        lda #"x"
        jsr printmonitorchar
        txa
        jsr printmonitorhex

        lda #"y"
        jsr printmonitorchar
        tya
        jsr printmonitorhex

    
        lda #"s"
        jsr printmonitorchar

        tsx
        txa
        clc
        adc #6
        jsr printmonitorhex

        lda #"f"
        jsr printmonitorchar

        
        tsx
        txa
        clc
        adc #4
        tax
        lda SPpage+$00,x
        
        jsr printmonitorhex
        

        lda #"p";
        jsr printmonitorchar


        tsx
        txa
        clc
        adc #5
        pha
                tax
                lda SPpage+$01,x
                jsr printhex
        pla
        tax
        lda SPpage+$00,x
        jsr printhex
        
        Jsr NewLine

        pla
        tay
        pla
        tax
        pla     ;Pop A
        plp     ;Pop F
        rts
printmonitorchar
        jsr PrintChar
        lda #":"
        jmp PrintChar
printmonitorhex
        jsr printhex
        lda #" "
        jmp PrintChar
       


