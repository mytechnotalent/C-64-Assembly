	ifdef BuildC64
		include "..\SrcC64\V1_Functions.asm"
	endif
	ifdef BuildVIC
		include "..\SrcVIC\V1_Functions.asm"
	endif
	ifdef BuildBBC
		include "..\SrcBBC\V1_Functions.asm"
	endif
	ifdef BuildAP2
		include "..\SrcAP2\V1_Functions.asm"
	endif
	ifdef BuildLNX
		include "..\SrcLNX\V1_Functions.asm"
	endif
	ifdef BuildPCE
		include "..\SrcPCE\V1_Functions.asm"
	endif
	ifdef BuildNES
		include "..\SrcNES\V1_Functions.asm"
	endif
	ifdef BuildSNS
		include "..\SrcSNS\V1_Functions.asm"
	endif
	ifdef BuildA52
		include "\SrcA52\V1_Functions.asm"
	endif
	ifdef BuildA80
		include "\SrcA52\V1_Functions.asm"
	endif