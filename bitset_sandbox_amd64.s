// gcc -c -O3

//unsigned long long popcount64(unsigned long long x) {
//  unsigned long long ret = 0;
//  for ( ; x != 0 ; ) {
//    ret += x & 1;
//    x >>= 1;
//  }
//  return ret;
//}

// objdump -d

//   0:	31 c0                	xor    %eax,%eax
//   2:	48 85 ff             	test   %rdi,%rdi
//   5:	74 19                	je     20 <popcount64+0x20>
//   7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
//   e:	00 00 
//  10:	48 89 fa             	mov    %rdi,%rdx
//  13:	83 e2 01             	and    $0x1,%edx
//  16:	48 01 d0             	add    %rdx,%rax
//  19:	48 d1 ef             	shr    %rdi
//  1c:	75 f2                	jne    10 <popcount64+0x10>
//  1e:	f3 c3                	repz retq 
//  20:	f3 c3                	repz retq 

#define NOSPLIT	4

//func asmnaive_popcount_2(x uint64) uint64
TEXT ·asmnaive_popcount_2(SB), NOSPLIT, $0
    MOVQ    x+0(FP),DI
    XORL    AX,AX
    TESTL   DI,DI
    JE      Z
	// no alignment
A:  MOVQ    DI,DX
    ANDL    $1,DX
    ADDQ    DX,AX
    SHRQ    $1,DI
    JNE     A
Z:  REP     
    MOVQ    AX,ret+8(FP)
    RET

//#define m1 0x5555555555555555
//#define m2 0x3333333333333333
//#define m4 0x0f0f0f0f0f0f0f0f

//unsigned long long hamming_popcount_2(unsigned long long x) {
//        x -= (x >> 1) & m1;
//        x = (x & m2) + ((x >> 2) & m2);
//        x = (x + (x >> 4)) & m4;
//        x += x >> 8;
//        x += x >> 16;
//        x += x >> 32;
//        return x & 0x7f;
//}

//   0:	48 89 f8             	mov    %rdi,%rax
//   3:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
//   a:	55 55 55 
//   d:	48 d1 e8             	shr    %rax
//  10:	48 21 d0             	and    %rdx,%rax
//  13:	48 29 c7             	sub    %rax,%rdi
//  16:	48 b8 33 33 33 33 33 	movabs $0x3333333333333333,%rax
//  1d:	33 33 33 
//  20:	48 89 fa             	mov    %rdi,%rdx
//  23:	48 c1 ef 02          	shr    $0x2,%rdi
//  27:	48 21 c2             	and    %rax,%rdx
//  2a:	48 21 c7             	and    %rax,%rdi
//  2d:	48 01 d7             	add    %rdx,%rdi
//  30:	48 89 f8             	mov    %rdi,%rax
//  33:	48 c1 e8 04          	shr    $0x4,%rax
//  37:	48 01 c7             	add    %rax,%rdi
//  3a:	48 b8 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rax
//  41:	0f 0f 0f 
//  44:	48 21 c7             	and    %rax,%rdi
//  47:	48 89 f8             	mov    %rdi,%rax
//  4a:	48 c1 e8 08          	shr    $0x8,%rax
//  4e:	48 01 c7             	add    %rax,%rdi
//  51:	48 89 f8             	mov    %rdi,%rax
//  54:	48 c1 e8 10          	shr    $0x10,%rax
//  58:	48 01 c7             	add    %rax,%rdi
//  5b:	48 89 f8             	mov    %rdi,%rax
//  5e:	48 c1 e8 20          	shr    $0x20,%rax
//  62:	48 01 f8             	add    %rdi,%rax
//  65:	83 e0 7f             	and    $0x7f,%eax
//  68:	c3                   	retq   

//func asmhamming_popcount_2(x uint64) uint64
TEXT ·asmhamming_popcount_2(SB), NOSPLIT, $0
    MOVQ    x+0(FP),DI
    MOVQ    DI,AX
    MOVQ    $0x5555555555555555,DX
    SHRQ    $1,AX
    ANDQ    DX,AX
    SUBQ    AX,DI
    MOVQ    $0x3333333333333333,AX
    MOVQ    DI,DX
    SHRQ    $2,DI
    ANDQ    AX,DX
    ANDQ    AX,DI
    ADDQ    DX,DI
    MOVQ    DI,AX
    SHRQ    $4,AX
    ADDQ    AX,DI
    MOVQ    $0xF0F0F0F0F0F0F0F,AX
    ANDQ    AX,DI
    MOVQ    DI,AX
    SHRQ    $8,AX
    ADDQ    AX,DI
    MOVQ    DI,AX
    SHRQ    $0x10,AX
    ADDQ    AX,DI
    MOVQ    DI,AX
    SHRQ    $0x20,AX
    ADDQ    DI,AX
    ANDQ    $0x7F,AX
    MOVQ    AX,ret+8(FP)
    RET
