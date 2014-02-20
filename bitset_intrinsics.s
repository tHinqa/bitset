#define NOSPLIT	4

//func cpuidcx() (flags uint32)
TEXT ·cpuidcx(SB), NOSPLIT, $0
	MOVL	$1,AX
	CPUID
	MOVL    CX,flags+0(FP)
	RET
