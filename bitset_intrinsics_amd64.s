
// gcc -mpopcnt -mlzcnt -O3 -c

// #include <x86intrin.h>
// int pop32(unsigned int x) {
//  	return __builtin_popcount(x);
// }
// int pop64(unsigned long long x) {
//  	return __builtin_popcountll(x);
// }
// int lz32(unsigned int x) {
// 	return __builtin_clz(x);
// }
// int lz64(unsigned long long x) {
// 	return __builtin_clzll(x);
// }

// objdump -d

// 0000000000000000 <pop32>:
//    0:	f3 0f b8 c7          	popcnt %edi,%eax
//    4:	c3                   	retq   

#define NOSPLIT	4

//func Popcnt32(x uint32) uint32
TEXT ·Popcnt32(SB), NOSPLIT, $0
    MOVL    x+0(FP),DI
//  POPCNTL DI,AX
    BYTE $0xf3; BYTE $0x0f; BYTE $0xb8;BYTE $0xC7
    MOVL    AX, ret+8(FP)
    RET

// 0000000000000010 <pop64>:
//   10:	f3 48 0f b8 c7       	popcnt %rdi,%rax
//   15:	c3                   	retq   

//func Popcnt64(x uint64) uint64
TEXT ·Popcnt64(SB), NOSPLIT, $0
    MOVQ    x+0(FP),DI
//	POPCNTQ DI,AX
    BYTE $0xf3; BYTE $0x48; BYTE $0x0f; BYTE $0xb8;BYTE $0xC7
    MOVQ    AX, ret+8(FP)
    RET

// 0000000000000020 <lz32>:
//   20:	f3 0f bd c7          	lzcnt  %edi,%eax
//   24:	c3                   	retq   

//func Lzcnt32(x uint32) uint32
TEXT ·Lzcnt32(SB), NOSPLIT, $0
    MOVL    x+0(FP),DI
//  LZCNTL  DI,AX
    BYTE $0xf3; BYTE $0x0f; BYTE $0xbd;BYTE $0xC7
    MOVL    AX, ret+8(FP)
    POPQ    BP
    RET

// 0000000000000030 <lz64>:
//  30:	f3 48 0f bd c7       	lzcnt  %rdi,%rax
//  35:	c3                   	retq   

//func Lzcnt64(x uint64) uint64
TEXT ·Lzcnt64(SB), NOSPLIT, $0
    MOVQ    x+0(FP),DI
//  LZCNTQ  DI,AX
    BYTE $0xf3; BYTE $0x48; BYTE $0x0f; BYTE $0xbd; BYTE $0xC7
    MOVQ    AX, ret+8(FP)
    RET
