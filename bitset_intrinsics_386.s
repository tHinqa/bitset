// gcc -O3 -mpopcnt -mlzcnt -c

//#include <x86intrin.h>
//int pop32(unsigned int x) {
//    return __builtin_popcount(x);
//}
//int lz32(unsigned int x) {
//    return __builtin_clz(x);
//}

// objdump -d

// 00000000 <_pop32>:
//    0:    f3 0f b8 44 24 04       popcnt 0x4(%esp),%eax
//    9:	c3                   	ret    

#define NOSPLIT	4

//func Popcnt32(x uint32) uint32
TEXT ·Popcnt32(SB), NOSPLIT, $0
//	POPCNTL	4(SP),AX == POPCNTL x+0(FP),AX
//	BYTE $0xf3; BYTE $0x0f; BYTE $0xb8;BYTE $0x44;BYTE $0x24;BYTE $0x04
	MOVL	AX, ret+4(FP)
	RET

// 0000000a <_lz32>:
//   0:   f3 0f bd 44 24 04       lzcnt  0x4(%esp),%eax
//  13:   c3                      ret    

//func Lzcnt32(x uint32) uint32
TEXT ·Lzcnt32(SB), NOSPLIT, $0
//	LZCNTL	4(SP),AX == LZCNTL  x+0(FP),AX
	BYTE $0xf3; BYTE $0x0f; BYTE $0xbd;BYTE $0x44;BYTE $0x24;BYTE $0x04
	MOVL	AX, ret+4(FP)
	RET

// CPU independent (compiled without -mlzcnt)
//00000000 <_lz32>:
//   0:   0f bd 44 24 04          bsr    0x4(%esp),%eax
//   5:   83 f0 1f                xor    $0x1f,%eax
//   8:   c3                      ret

//func Clz32(x uint32) uint32
TEXT ·Clz32(SB), NOSPLIT, $0
	MOVL	x+0(FP),CX
	ORL		CX,CX
	JZ		Z
	BSRL	CX,AX
	XORL	$0x1F,AX
	MOVL	AX,ret+4(FP)
	RET
Z:	MOVL	$32,ret+4(FP)
	RET
