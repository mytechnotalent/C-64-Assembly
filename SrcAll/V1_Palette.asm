	Ifdef BuildA52
		include "\SrcA52\A52_V1_Palette.asm"
	endif
	Ifdef BuildA80
		include "\SrcA52\A52_V1_Palette.asm"
	endif
	ifdef BuildLNX
		include "\SrcLNX\LNX_V1_Palette.asm"
	endif
	ifdef BuildPCE
		include "\SrcPCE\PCE_V1_Palette.asm"
	endif
	ifdef BuildNES
		include "\SrcNES\NES_V1_Palette.asm"
	endif
	
	ifdef BuildBBC
		include "\SrcBBC\BBC_V1_Palette.asm"
	endif
	ifdef BuildSNS
		include "\SrcSNS\SNS_V1_Palette.asm"
	endif
	ifdef BuildC64
SetPalette:
	rts
	endif
	ifdef BuildVIC
SetPalette:
	rts
	endif
	ifdef BuildAP2
SetPalette:
	rts
	endif
	
