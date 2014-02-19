#define NOSPLIT	4

//func cpuidcx() (flags uint32)
TEXT ·cpuidcx(SB), NOSPLIT, $0
	CPUID
	MOVL	CX,flags+0(FP)
	RET
