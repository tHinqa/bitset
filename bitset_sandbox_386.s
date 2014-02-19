// gcc -c -O3

//unsigned int popcount32(unsigned int x) {
//  unsigned int ret = 0;
//  for ( ; x != 0 ; ) {
//    ret += x & 1;
//    x >>= 1;
//  }
//  return ret;
//}

//   0:	8b 54 24 04          	mov    0x4(%esp),%edx
//   4:	31 c0                	xor    %eax,%eax
//   6:	85 d2                	test   %edx,%edx
//   8:	74 13                	je     1d <popcount32+0x1d>
//   a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
//  10:	89 d1                	mov    %edx,%ecx
//  12:	83 e1 01             	and    $0x1,%ecx
//  15:	01 c8                	add    %ecx,%eax
//  17:	d1 ea                	shr    %edx
//  19:	75 f5                	jne    10 <popcount32+0x10>
//  1b:	f3 c3                	repz ret 
//  1d:	f3 c3                	repz ret
//  1f:	90                   	nop

#define NOSPLIT	4

//func popcount32(x uint32) uint32
TEXT ·popcount32(SB), NOSPLIT, $0
    MOVL    x+0(FP), DX
    XORL    AX,AX
    TESTL   DX,DX
    JE      Z
    //LEAL  0(SI),SI // alignment - no effect discerned
A:  MOVL    DX,CX
    ANDL    $1,CX
    ADDL    CX,AX
    SHRL    $1,DX
    JNE     A
Z:  REP     
    MOVL    AX, ret+4(FP)
    RET

//#define m1 0x55555555
//#define m2 0x33333333
//#define m4 0x0f0f0f0f

//unsigned long long hamming_popcount_2(unsigned long long xi) {
//        unsigned long x1 = xi & 0xffffffff;
//        unsigned long x2 = xi >> 32;
//        x1 -= (x1 >> 1) & m1;
//        x1 = (x1 & m2) + ((x1 >> 2) & m2);
//        x1 = (x1 + (x1 >> 4)) & m4;
//        x1 += x1 >> 8;
//        x1 += x1 >> 16;
//        x2 -= (x2 >> 1) & m1;
//        x2 = (x2 & m2) + ((x2 >> 2) & m2);
//        x2 = (x2 + (x2 >> 4)) & m4;
//        x2 += x2 >> 8;
//        x2 += x2 >> 16;
//        return (x1+x2) & 0x7f;
//}
//   0: 53                      push   %ebx
//   1: 8b 44 24 08             mov    0x8(%esp),%eax
//   5: 8b 54 24 0c             mov    0xc(%esp),%edx
//   9: 89 c1                   mov    %eax,%ecx
//   b: d1 e9                   shr    %ecx
//   d: 81 e1 55 55 55 55       and    $0x55555555,%ecx
//  13: 29 c8                   sub    %ecx,%eax
//  15: 89 c1                   mov    %eax,%ecx
//  17: c1 e8 02                shr    $0x2,%eax
//  1a: 81 e1 33 33 33 33       and    $0x33333333,%ecx
//  20: 25 33 33 33 33          and    $0x33333333,%eax
//  25: 01 c8                   add    %ecx,%eax
//  27: 89 c1                   mov    %eax,%ecx
//  29: c1 e9 04                shr    $0x4,%ecx
//  2c: 01 c8                   add    %ecx,%eax
//  2e: 25 0f 0f 0f 0f          and    $0xf0f0f0f,%eax
//  33: 89 c1                   mov    %eax,%ecx
//  35: c1 e9 08                shr    $0x8,%ecx
//  38: 01 c8                   add    %ecx,%eax
//  3a: 89 d1                   mov    %edx,%ecx
//  3c: d1 e9                   shr    %ecx
//  3e: 89 c3                   mov    %eax,%ebx
//  40: 81 e1 55 55 55 55       and    $0x55555555,%ecx
//  46: 29 ca                   sub    %ecx,%edx
//  48: 89 d1                   mov    %edx,%ecx
//  4a: c1 ea 02                shr    $0x2,%edx
//  4d: 81 e1 33 33 33 33       and    $0x33333333,%ecx
//  53: 81 e2 33 33 33 33       and    $0x33333333,%edx
//  59: 01 ca                   add    %ecx,%edx
//  5b: 89 d1                   mov    %edx,%ecx
//  5d: c1 e9 04                shr    $0x4,%ecx
//  60: 01 ca                   add    %ecx,%edx
//  62: 81 e2 0f 0f 0f 0f       and    $0xf0f0f0f,%edx
//  68: 89 d1                   mov    %edx,%ecx
//  6a: c1 e9 08                shr    $0x8,%ecx
//  6d: 01 ca                   add    %ecx,%edx
//  6f: c1 eb 10                shr    $0x10,%ebx
//  72: 01 d3                   add    %edx,%ebx
//  74: 01 d8                   add    %ebx,%eax
//  76: c1 ea 10                shr    $0x10,%edx
//  79: 01 d0                   add    %edx,%eax
//  7b: 31 d2                   xor    %edx,%edx
//  7d: 83 e0 7f                and    $0x7f,%eax
//  80: 5b                      pop    %ebx
//  81: c3                      ret    

//func asmhamming_popcount_2(x uint64) uint64
TEXT ·asmhamming_popcount_2(SB), NOSPLIT, $0
    PUSHL   BX
    MOVL    x+0(FP),AX
    MOVL    x+4(FP),DX
    MOVL    AX,CX
    SHRL    $1,CX
    ANDL    $0x55555555,CX
    SUBL    CX,AX
    MOVL    AX,CX
    SHRL    $2,AX
    ANDL    $0x33333333,CX
    ANDL    $0x33333333,AX
    ADDL    CX,AX
    MOVL    AX,CX
    SHRL    $4,CX
    ADDL    CX,AX
    ANDL    $0xF0F0F0F,AX
    MOVL    AX,CX
    SHRL    $8,CX
    ADDL    CX,AX
    MOVL    DX,CX
    SHRL    $1,CX
    MOVL    AX,BX
    ANDL    $0x55555555,CX
    SUBL    CX,DX
    MOVL    DX,CX
    SHRL    $2,DX
    ANDL    $0x33333333,CX
    ANDL    $0x33333333,DX
    ADDL    CX,DX
    MOVL    DX,CX
    SHRL    $0X4,CX
    ADDL    CX,DX
    ANDL    $0xF0F0F0F,DX
    MOVL    DX,CX
    SHRL    $8,CX
    ADDL    CX,DX
    SHRL    $0x10,BX
    ADDL    DX,BX
    ADDL    BX,AX
    SHRL    $0x10,DX
    ADDL    DX,AX
    XORL    DX,DX
    ANDL    $0x7F,AX
    POPL    BX
    MOVL    AX,ret+8(FP)
    RET    
