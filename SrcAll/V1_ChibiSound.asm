
	ifdef BuildC64
		include "\SrcC64\C64_V1_ChibiSound.asm"
	endif
	ifdef BuildVIC
		include "\SrcVIC\VIC_V1_ChibiSound.asm"
	endif
	ifdef BuildBBC
		include "\SrcBBC\BBC_V1_ChibiSound.asm"
	endif
	ifdef BuildAP2
		include "\SrcAP2\AP2_V1_ChibiSound.asm"
	endif
	ifdef BuildLNX
		include "\SrcLNX\LNX_V1_ChibiSound.asm"
	endif
	ifdef BuildPCE
		include "\SrcPCE\PCE_V1_ChibiSound.asm"
	endif
	ifdef BuildNES
		include "\SrcNES\NES_V1_ChibiSound.asm"
	endif
	ifdef BuildSNS
		include "\SrcSNS\SNS_V1_ChibiSound.asm"
	endif
	ifdef BuildA52
		include "\SrcA52\A52_V1_ChibiSound.asm"
	endif
	ifdef BuildA80
		include "\SrcA52\A52_V1_ChibiSound.asm"
	endif