	ifdef BuildPCE
		include "..\SrcPCE\V1_Footer.asm"
	endif
	ifdef BuildNES
		include "..\SrcNES\V1_Footer.asm"
	endif
		
	ifdef BuildSNS
		include "..\SrcSNS\V1_Footer.asm"
	endif
			
	ifdef BuildA52
		include "..\SrcA52\V1_Footer.asm"
	endif
	ifdef BuildA80
		include "..\SrcA52\V1_Footer.asm"
	endif
	ifdef BuildBBC
		include "..\SrcBBC\V1_Footer.asm"
	endif