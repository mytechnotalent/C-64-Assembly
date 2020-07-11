
ShowTile:	;A=Tilenum, BC=XYpos
	ifdef BuildC64
	sta z_as		;Need A for color later
	endif
	ifdef BMPTILE
		pha
			jsr GetVDPScreenPos			;INIT the VDP to save the new tile position
		pla
		ifndef BuildVIC
			clc
			adc #128					;On all systems except VIC the first 128 tiles are our font.
		endif
		ifdef BuildNES
			sta VDPBuffer,Y				;Add the command to the update queue
			iny
			sty VDP_CT					;Save the new command count
				
			
		endif
		ifdef BuildPCE
			st0 #2						;Save the TileNum to PCE Vram
			sta_00 $02
			st2 #%00000001
		endif
		ifdef BuildSNS
			ldy #0
			sta (z_hl),y				;update the buffer memory with the new tile (it will be stored to vram during the next NMI)
			iny
			;pla
			lda #0
			sta (z_hl),y

		endif
		ifdef BuildVIC	
			ldy #0
			sta (z_hl),y				;Set the tile in graphics memory
			tax
			lda #$78					;Offset HL ram to the color ram location
			clc 
			adc z_h
			sta z_h
			lda RawPalettes,X			;Get the color for this tiles
			sta (z_hl),y				;Save to color ram
		endif
	endif
	ifdef BMPBBC
BMPNORMALorBBC equ 1
	endif
	ifdef BMPNORMAL
BMPNORMALorBBC equ 1
	endif
	
	
	
	ifdef BMPNORMALorBBC
		
		
	sta z_E
	lda #0
	;sta z_D

	clc
	rol z_E
	rol ;z_D		;2
	rol z_E
	rol ;z_D		;4
	rol z_E
	rol ;z_D		;8
	ifdef TileWidth2
		rol z_E
		rol ; z_D		;16
	endif
	ifdef BuildAP2 				;Apple2 4color mode exporter works in multiples of 14 
		rol z_E
		rol ; z_D		;16
	endif
	
	ifdef TileWidth4
		rol z_E
		rol ;z_D		;32
		rol z_E
		rol ; z_D		;32
	endif
	
	ifdef BuildAP2
			
		pha
			lda z_b
			and #%00000001		;We have to use an alternate tile for every other column to keep colors right on the apple 
			beq TileA52Odd
		
			lda z_e
			clc
			adc #1				;Shift to next tile every other column
			sta z_e
					
		
TileA52Odd:
		pla
		endif	
	sta z_D
	
	lda #<RawBitmap
	sta z_L
	lda #>RawBitmap
	sta z_H
	
	lda z_b
	clc
	ifdef BMPNORMAL			;BBC type goes down then across - so we don't double our Xpos
		ifdef TileWidth2
			rol 
		endif
		ifdef TileWidth4
			rol
			rol
		endif 
	endif
	tax
	lda z_c
	clc
	rol 
	rol
	rol
	tay
	
	jsr AddHL_DE			; Calculate source position of tile data
	
	endif
	
	ifdef BMPNORMAL
	
	pushpair z_bc
		ifdef ShortTile		;Convert screen pos for 8x6 tiles on Lynx
		clc
		tya
		ror
		sta z_c
		ror
		clc
		adc z_c
		tay
		endif
	
		lda #0
	Tile_NexBitmapNextStrip:
		pushall
			jsr GetScreenPos
		ifdef ShortTile
			ldx #6
		else
			ldx #8
		endif
		
	Tile_BitmapNextLine:
		txa
		pha
		
		;PushPair z_de
		ifdef ShortTile
			cmp #1
			beq LnxSkipLine
			cmp #5
			beq LnxSkipLine
			jmp LnxDontSkipLine
LnxSkipLine:	
			AddPair z_Hl,4				;Skip 4 bytes (8 pixes) on unwanted lines
LnxDontSkipLine:	
		endif
		ldY #0
		ldx #0
Tile_BitmapNextByte:
			
			lda (z_hl,X)				;read a byte in from HL and write it to DE
			sta (z_de),Y
			INC z_L
			BNE	TileIncHL_Done
			INC	z_H
TileIncHL_Done:
			
			ifdef TileWidth4
				inY
				cpY #4
				bne Tile_BitmapNextByte		;Repeat until end of line (x)
			endif
			ifdef TileWidth2
				inY
				cpY #2
				bne Tile_BitmapNextByte
			endif
			;ifdef TileWidth1
			;	cpY #1
			;endif
			
			
		
			ifdef BuildAP2 					;Apple2 4color mode exporter works in multiples of 14 
				jsr IncHL
			endif
		;PullPair z_de
		
		pla
		tax									;Decrease line count
		dex	
		beq Tile_BitmapDone					;See if we're done
		
		jsr GetNextLine						;Move destination to next screen line
		
		jmp Tile_BitmapNextLine
		
Tile_BitmapDone:		
		pullall
	pullpair z_bc
	rts

	
	endif 	;End of BMPNORMAL	
	
	
	
	ifdef BMPBBC
	
	ifdef BuildBBC
		txa
		clc									;Convert Tile->byte on BBC
		rol
		tax
	endif
	
NexBitmapNextStrip:

	jsr GetScreenPos
BitmapNextLine:
		ifdef TileWidth4
			ldy #(4*8)-1				;Bytes in tile
		endif
		ifdef TileWidth2
			ldy #(2*8)-1
		endif
		ifdef TileWidth1
			ldy #(1*8)-1
		endif
BitmapNextByte:
		lda (z_hl),Y					;Copy bytes to screen
		sta (z_de),Y
		dey
		bpl BitmapNextByte

	endif	; BMPBBC
	
	ifdef BuildC64
		
		lda z_b					
		tax
		lda z_c
		asl
		asl
		asl
		tay
		
		jsr GetColMemPos		;Get address of tile color info
		lda z_as
		asl
		tax
		lda RawPalettes,x		;Get color for this tile
		ldy #0
		sta (z_de),y			;Store main color info in screen color ram
		
		lda #$D4				;Move to color registers
		clc
		adc z_d
		sta	z_d
		inx 
		lda RawPalettes,x		
		sta (z_de),y			;Store 3rd palette entry in color registers
	endif
	
	rts