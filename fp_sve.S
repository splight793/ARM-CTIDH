/****************************************************************************
*   Efficient implementation of finite field arithmetic over p511 on 512-bit SVE
*                   Implementation of CTIDH
*
*   Author: PENGCHANG REN                    splight@outlook.com
*                       
*                       All rights reserved   
*****************************************************************************/
#include "uintbig_namespace.h"
#include "fp_namespace.h"
.data
.global fp_0
fp_0:
    .quad 0,0,0,0,0,0,0,0

.global fp_1
fp_1: /* 2^512 mod p */
    .quad 0xc8fc8df598726f0a, 0x7b1bc81750a6af95, 0x5d319e67c1e961b4, 0xb0aa7275301955f1
    .quad 0x4a080672d9ba6c64, 0x97a5ef8a246ee77b, 0x06ea9e5d4383676a, 0x3496e2e117e0ec80

.global fp_2
fp_2: /* 2^513 mod p */
    .quad 0x767762e5fd1e1599, 0x33c5743a49a0b6f6, 0x68fc0c0364c77443, 0xb9aa1e24f83f56db
    .quad 0x3914101f20520efb, 0x7b1ed6d95b1542b4, 0x114a8be928c8828a, 0x03793732bbb24f40
.global fp_mulsq_count
fp_mulsq_count:
    .quad 0
.global fp_sq_count
fp_sq_count:
    .quad 0
.global fp_addsub_count
fp_addsub_count:
    .quad 0
.global uintbig_1
uintbig_1:
    .quad 1, 0, 0, 0
    .quad 0, 0, 0, 0

.global uintbig_p
uintbig_p:
    .quad 0x1b81b90533c6c87b, 0xc2721bf457aca835, 0x516730cc1f0b4f25, 0xa7aac6c567f35507
    .quad 0x5afbfcc69322c9cd, 0xb42d083aedc88c42, 0xfc8ab0d15e3e4c4a, 0x65b48e8f740f89bf

.global uintbig_four_sqrt_p
uintbig_four_sqrt_p:
    .quad 0x17895e71e1a20b3f, 0x38d0cd95f8636a56, 0x142b9541e59682cd, 0x856f1399d91d6592
    .quad 2, 0, 0, 0

p511:
.quad 0x1b81b90533c6c87b
.quad 0xc2721bf457aca835
.quad 0x516730cc1f0b4f25
.quad 0xa7aac6c567f35507
.quad 0x5afbfcc69322c9cd
.quad 0xb42d083aedc88c42
.quad 0xfc8ab0d15e3e4c4a
.quad 0x65b48e8f740f89bf
.quad 0xe47e46facc393785
.quad 0x3d8de40ba85357ca
.quad 0xae98cf33e0f4b0da
.quad 0x5855393a980caaf8
.quad 0xa50403396cdd3632
.quad 0x4bd2f7c5123773bd
.quad 0x3754f2ea1c1b3b5
.quad 0x9a4b71708bf07640

minus_p511_inverse:
.quad 0x66c1301f632e294d

tbl1:
.quad 0
.quad 1
.quad 2
.quad 3
.quad 4
.quad 5
.quad 6
.quad 7
.quad 0x3830282018100800
tbl2:
.quad 0xff0e0d0c0b0a0908
.quad 0xff1514131211100f
.quad 0xff1c1b1a19181716
.quad 0xff232221201f1e1d
.quad 0xff2a292827262524
.quad 0xff31302f2e2d2c2b
.quad 0xff38373635343332
.quad 0xff3f3e3d3c3b3a39

r_inverses:
.quad 0x93ef9bd5f83f7c81
.quad 0x468665440e5dff9d
.quad 0x48d6b7835cbf6393
.quad 0x6ad34b1fe60d1f90
.quad 0x9673bd6e3070a8d
.quad 0x86dfda336aae9bfa
.quad 0xedaed770dbf910ff
.quad 0x1515dee5ee3040ae
.quad 0xf887ea68802344ff
.quad 0xb98a6b3d19afb738
.quad 0x40dda5c0410237f8
.quad 0x4f23a026a4cc4b03
.quad 0xc1c9e19aa4dc0ca7
.quad 0x24dcad2fb1b693e2
.quad 0x34d2e660043c0e94
.quad 0x1b70e545d10ea0bb
.quad 0x3519e82df6f0bfb1
.quad 0x9b26a907b153657c
.quad 0xad2eec4751ce7395
.quad 0xf0f9666b61cb2c11
.quad 0xdf3fdbfac213dcc5
.quad 0x4a25cf2dd6229163
.quad 0xe570a9b3e4837681
.quad 0x5e9a0dd1bc15f3eb
.quad 0xd48d367148680ec3
.quad 0xdb47e82028473057
.quad 0x532bf424d02ca63a
.quad 0x21075c375d383413
.quad 0x71f64ec262600e53
.quad 0xf2f868214f85d120
.quad 0xf699f2ef4c802a05
.quad 0x52c8a6c14a873a8d
.quad 0x7f9fee697ee66dc3
.quad 0xf55746029e0e0a5
.quad 0xdd84db321cf8e062
.quad 0xd4fe009af69b49f5
.quad 0x46bf5e2b3977df1e
.quad 0x2d110825959dd412
.quad 0x664e4391c11b5e49
.quad 0x601741bf99fc0b15
.quad 0x5f86d4240804957
.quad 0xf1bcf070d1d05dd0
.quad 0x87ea3f303521cc59
.quad 0x8a0d36909150d54
.quad 0xd9904fc8b9005ec8
.quad 0xd9082bd7b29fa718
.quad 0xff57a4499ee70f7
.quad 0x4d91640e46066c00
.quad 0xdcc27738ccf1650a
.quad 0xfbc538f236eeee2f
.quad 0x238401e69aa8c484
.quad 0x4e6329e8d08aa658
.quad 0x10c0e36fe03dece8
.quad 0x5d5cb29b0ab125a
.quad 0x33f51c8713b61b2
.quad 0x25ae09f33553c575
.quad 0x1820feed5f9f70fe
.quad 0x369410fd54380214
.quad 0xcc38935722ddb744
.quad 0xf420accc5a421c27
.quad 0x437275682616c6a
.quad 0x44d28b637b0383d0
.quad 0x3fc9f548afe97b85
.quad 0x4cc03dcd25d2d46b
.text
.macro MULTIPLY B0, B1, T0, ADDRESS, P1, P2
    movprfx z1,     \B0
    umulh   z1.d,   p0/m,   z1.d,   z0.d    //FL*       9
    movprfx z17,    \B1
    mul     z17.d,  p0/m,   z17.d,  z0.d    //FL*       9
    add     z1.d,   z1.d,   z17.d           //FL*       4
    sel     z24.d,  \P1,    z19.d,  z24.d   //FL*       4
    add     z24.d,  z24.d,  z1.d            //FL*       4
    cmphi   p3.d,   p0/z,   z17.d,  z1.d    //PRX;FLA   4
    sel     z23.d,  \P1,    z21.d,  z23.d   //FL*       4
    ld1rd   \T0,    p0/z,   [x1, \ADDRESS]  //EAG*      9
    cmphi   p4.d,   p0/z,   z1.d,   z24.d   //PRX;FLA   4
    sub     z23.d,  p3/m,   z23.d,  z22.d   //FL*       4
    sel     z18.d,  \P2,    z24.d,  z18.d   //FL*       4
    sub     z23.d,  p4/m,   z23.d,  z22.d   //FL*       4
    sel     z20.d,  \P2,    z23.d,  z20.d   //FL*       4
    ext     z0.b,   z0.b,   z0.b,   #56     //FLA       6
.endm

.macro mul2 H, index
    dup z17.d, z16.d[\index]
    movprfx z19, z17
    mul z19.d, p0/m, z19.d, \H
    add z18.d, z18.d, z19.d
    cmphi p1.d, p0/z, z19.d, z18.d
    umulh \H, p0/m, \H, z17.d
    sub z30.d, z30.d, \H
    add z30.d, p1/m, z30.d, z22.d
.endm

.global fp_add3
.global fp_sub3
.global mp_add_512

.global mp_mul_u64
.global fp_mul3
.global initPredicate
initPredicate:
    ptrue   p0.d
    mov     x9,     #8
    mov     x10,    #7
    mov     x11,    #6
    mov     x12,    #5
    mov     x13,    #4
    mov     x14,    #3
    mov     x15,    #2
    mov     x16,    #1
    whilelo p8.d,   x10,    x9     //p8 = [F, F, F, F, F, F, F, T]
    whilelo p1.d,   x11,    x9     //p1 = [F, F, F, F, F, F, T, T]
    whilelo p2.d,   x12,    x9     //p2 = [F, F, F, F, F, T, T, T]
    whilelo p3.d,   x13,    x9     //p3 = [F, F, F, F, T, T, T, T]
    whilelo p4.d,   x14,    x9     //p4 = [F, F, F, T, T, T, T, T]
    whilelo p5.d,   x15,    x9     //p5 = [F, F, T, T, T, T, T, T]
    whilelo p6.d,   x16,    x9     //p6 = [F, T, T, T, T, T, T, T]
    eor     p9.b,   p0/z,   p8.b,   p1.b
    eor     p10.b,  p0/z,   p1.b,   p2.b
    eor     p11.b,  p0/z,   p2.b,   p3.b
    eor     p12.b,  p0/z,   p3.b,   p4.b
    eor     p13.b,  p0/z,   p4.b,   p5.b
    eor     p14.b,  p0/z,   p5.b,   p6.b
    eor     p15.b,  p0/z,   p6.b,   p0.b
    ret

mp_add_512:
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
     
    ldp     x11, x12, [x1]
    ldp     x13, x14, [x1,#16]
    ldp     x15, x16, [x1,#32]
    ldp     x17, x18, [x1,#48]

    adds    x3, x3, x11
    adcs    x4, x4, x12
    adcs    x5, x5, x13
    adcs    x6, x6, x14
    adcs    x7, x7, x15
    adcs    x8, x8, x16
    adcs    x9, x9, x17
    adcs    x10, x10, x18
    adc     x0, xzr, xzr

    stp     x3, x4, [x2]
    stp     x5, x6, [x2,#16]
    stp     x7, x8, [x2,#32]
    stp     x9, x10, [x2,#48]
    
    ret//*/
/*
mp_add_512:
    ld1d    { z0.d },   p0/z,       [x0]
    ld1d    { z1.d },   p0/z,       [x1]
    ldr     x0,         =tbl1
    ld1d    z26.d,      p0/z,       [x0]
    add     x1, x0, #64
    ldr     d28,        [x1]
    eor     z20.d, z20.d, z20.d
    not     z22.d,  p0/m,   z20.d
    add     z2.d,       z0.d,       z1.d
    cmphi   p1.d,       p0/z,       z1.d,       z2.d
    movprfx z21,        z20
    sub     z21.b,      z21.b,      #65
    cnt     z27.d,      p0/m,       z2.d
    sub     z27.b,      p1/m,       z27.b,      z21.b
    tbl     z23.b,      { z27.b },  z28.b
    add     z23.d,      z23.d,      z21.d
    add     z27.b,      z27.b,      z21.b
    tbl     z24.b,      { z23.b } , z26.b
    cmpne   p3.b,       p0/z,       z24.b,      z27.b
    sub     z2.d,       p3/m,       z2.d,       z22.d
    st1d    { z2.d },  p0,         [x2]
    ret
    //*/
.global mp_sub_512
/*
mp_sub_512:
    ld1d    { z0.d },   p0/z,       [x0]
    ld1d    { z1.d },   p0/z,       [x1]
    ldr     x0,         =tbl1
    ld1d    z26.d,      p0/z,       [x0]
    add     x1, x0, #64
    ldr     d28,        [x1]
    eor     z20.d,      z20.d,      z20.d
    not     z22.d,      p0/m,       z20.d
    not     z1.d,       p0/m,       z1.d
    add     z2.d,       z0.d,       z1.d
    cmphi   p1.d,       p0/z,       z1.d,       z2.d
    movprfx z21,        z20
    sub     z21.b,      z21.b,      #65
    cnt     z27.d,      p0/m,       z2.d
    sub     z27.b,      p1/m,       z27.b,      z21.b
    tbl     z23.b,      { z27.b },  z28.b
    add     z23.d,      z23.d,      z21.d
    add     z23.d,      z23.d,      #1
    add     z27.b,      z27.b,      z21.b
    tbl     z24.b,      { z23.b } , z26.b
    cmpne   p3.b,       p0/z,       z24.b,      z27.b
    sub     z2.d,       p3/m,       z2.d,       z22.d
    st1d    { z2.d },  p0,         [x2]
    ret*/
mp_sub_512:
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
     
    ldp     x11, x12, [x1]
    ldp     x13, x14, [x1,#16]
    ldp     x15, x16, [x1,#32]
    ldp     x17, x18, [x1,#48]

    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18
    cset    x0,  cc

    stp     x3, x4, [x2]
    stp     x5, x6, [x2,#16]
    stp     x7, x8, [x2,#32]
    stp     x9, x10, [x2,#48]
    ret
/*
fp_add_512:
    ptrue   p0.d
    ld1d    { z0.d },   p0/z,       [x0]
    ld1d    { z1.d },   p0/z,       [x1]
    ldr     x0,         =p511 + 64
    ld1d    z29.d,      p0/z,       [x0]
    ldr     x0,         =tbl1
    ld1d    z26.d,      p0/z,       [x0]
    add     x1, x0, #64
    ldr     d28,        [x1]
    eor     z20.d,      z20.d,      z20.d
    mov     z22.d,      #1
    add     z0.d,       z0.d,       z1.d
    cmphi   p1.d,       p0/z,       z1.d,       z0.d
    sel     z1.d,       p1,         z22.d,      z20.d
    //check if > p
    dup     z18.b,      z0.b[63]
    cmphs   p2.b,       p0/z,       z18.b,      #102
    sel     z29.d,      p2,         z29.d,      z20.d
    add     z0.d,       z0.d,       z29.d
    cmphi   p1.d,       p0/z,       z29.d,      z0.d
    add     z1.d,       p1/m,       z1.d,       z22.d

    ext     z20.b,       z20.b,       z1.b,      #56
    add     z2.d,       z0.d,       z20.d
    cmphi   p1.d,       p0/z,       z0.d,       z2.d
    dup     z21.b,      #-65
    cnt     z27.d,      p0/m,       z2.d
    sub     z27.b,      p1/m,       z27.b,      z21.b
    tbl     z23.b,      { z27.b },  z28.b
    add     z23.d,      z23.d,      z21.d
    add     z27.b,      z27.b,      z21.b
    tbl     z24.b,      { z23.b } , z26.b
    cmpne   p3.b,       p0/z,       z24.b,      z27.b
    add     z2.d,       p3/m,       z2.d,       z22.d
    st1d    { z2.d },   p0,         [x2]
    ret

/*
fp_sub_512:
    ld1d    { z0.d },   p0/z,       [x0]
    ld1d    { z1.d },   p0/z,       [x1]
    ldr     x0,         =p511
    ld1d    z29.d,      p0/z,       [x0]
    ldr     x0,         =tbl1
    ld1d    z26.d,      p0/z,       [x0]
    add     x1, x0, #64
    ldr     d28,        [x1]
    eor     z20.d,      z20.d,      z20.d
    not     z1.d,       p0/m,       z1.d
    mov     z22.d,      #1
    add     z0.d,       z0.d,       z1.d
    cmphi   p1.d,       p0/z,       z1.d,       z0.d
    sel     z1.d,       p1,         z22.d,      z20.d
    //check if > p
    dup     z18.b,      z0.b[63]
    cmphs   p2.b,       p0/z,       z18.b,      #102
    sel     z29.d,      p2,         z29.d,      z20.d
    add     z0.d,       z0.d,       z29.d
    cmphi   p1.d,       p0/z,       z29.d,      z0.d
    add     z1.d,       p1/m,       z1.d,       z22.d

    ext     z20.b,       z20.b,       z1.b,      #56
    add     z2.d,       z0.d,       z20.d
    cmphi   p1.d,       p0/z,       z0.d,       z2.d
    dup     z21.b,      #-65
    cnt     z27.d,      p0/m,       z2.d
    sub     z27.b,      p1/m,       z27.b,      z21.b
    tbl     z23.b,      { z27.b },  z28.b
    add     z23.d,      z23.d,      z21.d
    add     z23.d,      z23.d,      #1
    add     z27.b,      z27.b,      z21.b
    tbl     z24.b,      { z23.b } , z26.b
    cmpne   p3.b,       p0/z,       z24.b,      z27.b
    add     z2.d,       p3/m,       z2.d,       z22.d
    st1d    { z2.d },   p0,         [x2]
    ret
*/

fp_add3:
    ldp     x3, x4,   [x2]
    ldp     x5, x6,   [x2,#16]
    ldp     x7, x8,   [x2,#32]
    ldp     x9, x10,  [x2,#48]
     
    ldp     x11, x12, [x1]
    ldp     x13, x14, [x1,#16]
    ldp     x15, x16, [x1,#32]
    ldp     x17, x18, [x1,#48]  

    adds    x3, x3, x11
    adcs    x4, x4, x12
    adcs    x5, x5, x13
    adcs    x6, x6, x14
    adcs    x7, x7, x15
    adcs    x8, x8, x16
    adcs    x9, x9, x17
    adcs    x10, x10, x18

    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
    mov     x1, x19
    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18
    sbc     x19, xzr, xzr

    and     x11, x11, x19
    adds    x3, x3, x11
    and     x12, x12, x19
    adcs    x4, x4, x12
    and     x13, x13, x19
    adcs    x5, x5, x13
    and     x14, x14, x19
    adcs    x6, x6, x14
    and     x15, x15, x19
    adcs    x7, x7, x15
    and     x16, x16, x19
    adcs    x8, x8, x16
    and     x17, x17, x19
    adcs    x9, x9, x17 
    and     x18, x18, x19
    adcs    x10, x10, x18
    mov     x19, x1
    stp     x3, x4, [x0]
    stp     x5, x6, [x0,#16]
    stp     x7, x8, [x0,#32]
    stp     x9, x10, [x0,#48]
    
    ret
//*/
fp_sub3:

    ldp     x3, x4,   [x2]
    ldp     x5, x6,   [x2,#16]
    ldp     x7, x8,   [x2,#32]
    ldp     x9, x10,  [x2,#48]

    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18

    csel    x11, x11, xzr, lo
    csel    x12, x12, xzr, lo
    csel    x13, x13, xzr, lo
    csel    x14, x14, xzr, lo
    csel    x15, x15, xzr, lo
    csel    x16, x16, xzr, lo
    csel    x17, x17, xzr, lo
    csel    x18, x18, xzr, lo

    adds    x11, x3, x11
    adcs    x12, x4, x12    
    adcs    x13, x5, x13    
    adcs    x14, x6, x14    
    adcs    x15, x7, x15    
    adcs    x16, x8, x16    
    adcs    x17, x9, x17    
    adcs    x18, x10, x18
    stp     x11, x12, [x2]
    stp     x13, x14, [x2,#16]
    stp     x15, x16, [x2,#32]
    stp     x17, x18, [x2,#48] 
    ldp     x3, x4,   [x1]
    ldp     x5, x6,   [x1,#16]
    ldp     x7, x8,   [x1,#32]
    ldp     x9, x10,  [x1,#48]
    mov     x1, x19
    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18
    sbc     x19, xzr, xzr

    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56

    and     x11, x11, x19
    adds    x3, x3, x11
    and     x12, x12, x19
    adcs    x4, x4, x12
    and     x13, x13, x19
    adcs    x5, x5, x13
    and     x14, x14, x19
    adcs    x6, x6, x14
    and     x15, x15, x19
    adcs    x7, x7, x15
    and     x16, x16, x19
    adcs    x8, x8, x16
    and     x17, x17, x19
    adcs    x9, x9, x17 
    and     x18, x18, x19
    adcs    x10, x10, x18
    mov     x19, x1
    stp     x3, x4, [x0]
    stp     x5, x6, [x0,#16]
    stp     x7, x8, [x0,#32]
    stp     x9, x10, [x0,#48]
    ret
mp_mul_u64:
    ld1d    { z2.d },   p0/z,       [x0]
    dup     z1.d,       x1
    movprfx z0,         z2
    mul     z0.d,       p0/m,       z0.d,    z1.d
    umulh   z1.d,       p0/m,       z1.d,    z2.d
    ext     z1.b,       z1.b,       z1.b,    #56
    ldr     x0,         =tbl1
    ld1d    z26.d,      p0/z,       [x0]
    add     x1,         x0,         #64
    ldr     d28,        [x1]
    eor     z20.d,      z20.d,      z20.d
    not     z22.d,      p0/m,       z20.d
    not     p2.b,       p0/z,       p8.b
    add     z0.d,       p2/m,       z0.d,       z1.d
    cmphi   p1.d,       p2/z,       z1.d,       z0.d
    movprfx z21,        z20
    sub     z21.b,      z21.b,      #65
    cnt     z27.d,      p0/m,       z2.d
    sub     z27.b,      p1/m,       z27.b,      z21.b
    tbl     z23.b,      { z27.b },  z28.b
    add     z23.d,      z23.d,      z21.d
    add     z27.b,      z27.b,      z21.b
    tbl     z24.b,      { z23.b } , z26.b
    cmpne   p3.b,       p0/z,       z24.b,      z27.b
    sub     z0.d,       p3/m,       z0.d,       z22.d
    st1d    { z0.d },   p0,         [x2]
    ret


fp_mul3:
    ld1d    z0.d,       p0/z,       [x2]        //z0 = a[0-7]
    ld1rd   z2.d,       p0/z,       [x1]        //z2 = b[0]
    ld1rd   z16.d,      p0/z,       [x1, #56]   //z16 = b[7]
    mov x2, x0
    movprfx z24,        z2
    mul     z24.d,      p0/m,       z24.d,      z0.d
    movprfx z19,        z16
    umulh   z19.d,      p0/m,       z19.d,      z0.d
    ld1rd   z3.d,       p0/z,       [x1, #8]
    eor     z20.d,      z20.d,      z20.d       //z20=0
    eor     z21.d,      z21.d,      z21.d       //z21=0
    eor     z23.d,      z23.d,      z23.d       //z23=0
    ext     z0.b,       z0.b,       z0.b,       #56 //Rotate shift
    mov     z18.d,      z24.d
    not     z22.d,      p0/m,       z21.d       //z22=-1
    
    MULTIPLY z2, z3, z2.d, #16, p8, p9
    MULTIPLY z3, z2, z3.d, #24, p9, p10
    MULTIPLY z2, z3, z2.d, #32, p10, p11
    MULTIPLY z3, z2, z3.d, #40, p11, p12
    MULTIPLY z2, z3, z2.d, #48, p12, p13
    //MULTIPLY #56 ld1rd is not required
    movprfx z1,         z3
    umulh   z1.d,       p0/m,       z1.d,       z0.d
    movprfx z17,        z2
    mul     z17.d,      p0/m,       z17.d,      z0.d
    mov     p5.b,       p0/z,       p1.b
    add     z1.d,       z1.d,       z17.d
    sel     z24.d,      p13,        z19.d,      z24.d
    add     z24.d,      z24.d,      z1.d
    cmphi   p3.d,       p0/z,       z17.d,      z1.d
    sel     z23.d,      p13,        z21.d,      z23.d
    cmphi   p4.d,       p0/z,       z1.d,       z24.d
    sub     z23.d,      p3/m,       z23.d,      z22.d
    sel     z18.d,      p14,        z24.d,      z18.d
    sub     z23.d,      p4/m,       z23.d,      z22.d
    ext     z0.b,       z0.b,       z0.b,       #56
    sel     z20.d,      p14,        z23.d,      z20.d

    movprfx z1,         z2
    umulh   z1.d,       p0/m,       z1.d,       z0.d
    movprfx z17,        z16
    mul     z17.d,      p0/m,       z17.d,      z0.d
    add     z1.d,       z1.d,       z17.d
    sel     z24.d,      p14,        z19.d,      z24.d
    add     z24.d,      z24.d,      z1.d
    cmphi   p3.d,       p0/z,       z17.d,      z1.d
    sel     z23.d,      p14,        z21.d,      z23.d
    cmphi   p4.d,       p0/z,       z1.d,       z24.d
    eor     p2.b,       p0/z,       p0.b,       p1.b
    sub     z23.d,      p3/m,       z23.d,      z22.d
    sel     z28.d,      p15,        z24.d,      z18.d
    sub     z23.d,      p4/m,       z23.d,      z22.d
    sel     z30.d,      p15,        z23.d,      z20.d

    sel     z29.d,      p15,        z19.d,      z24.d
    sel     z31.d,      p15,        z21.d,      z23.d
    
    //start reduction
    ldr     x0,         =r_inverses
    ldr     x1,         =tbl2
    ld1d    z0.d,       p0/z,       [x0]
    ld1d    z1.d,       p0/z,       [x1]
    add     x0,         x0,         #64
    ld1d    z2.d,       p0/z,       [x0]
    add     x0,         x0,         #64
    ld1d    z3.d,       p0/z,       [x0]
    add     x0,         x0,         #64
    ld1d    z4.d,       p0/z,       [x0]
    add     x0,         x0,         #64
    ld1d    z5.d,       p0/z,       [x0]
    add     x0,         x0,         #64
    ld1d    z6.d,       p0/z,       [x0]
    add     x0,         x0,         #64
    ld1d    z7.d,       p0/z,       [x0]
    eor     z20.d,      z2.d,       z2.d
    sub     z1.b,       z1.b,       #8
    tbl     z16.b,      z28.b,      z1.b
    sub     z1.b,       z1.b,       #8
    tbl     z17.b,      z30.b,      z1.b
    add     z16.d,      z16.d,      z17.d
    add     x0,         x0,         #64
    ld1d    z1.d,       p0/z,       [x0]
    ldr     x3,         =minus_p511_inverse
    ld1rd   z23.d,      p0/z,       [x3]
    ldr     x4,         =p511
    ld1d    z21.d,      p0/z,       [x4]
    add     x4,         x4,         #64
    movprfx z18,        z28
    ext     z18.b,      z18.b,      z20.b,      #56
    ext     z30.b,      z30.b,      z20.b,      #48
    add     z18.d,      z18.d,      z30.d
    cmphi   p1.d,       p0/z,       z30.d,      z18.d
    sel     z30.d,      p1,         z22.d,      z20.d
    mul2    z0.d,       0
    mul2    z2.d,       1
    mul2    z3.d,       2
    mul2    z4.d,       3
    mul2    z5.d,       4
    mul2    z6.d,       5
    mul2    z7.d,       6
    mul2    z1.d,       7
    ldr     x0,         =tbl1
    ld1d    z26.d,      p0/z,       [x0]
    add     x1,         x0, #64
    ldr     d28,        [x1]
    dup     z17.d,      z18.d[0]
    mul     z17.d,      p0/m,       z17.d,      z23.d
    movprfx z19,        z17
    mul     z19.d,      p0/m,       z19.d,      z21.d
    add     z18.d,      z18.d,      z19.d
    cmphi   p1.d,       p0/z,       z19.d,      z18.d
    umulh   z17.d,      p0/m,       z17.d,      z21.d
    ld1d    z21.d,      p0/z,       [x4]
    add     z30.d,      p1/m,       z30.d,      z22.d
    neg     z30.d,      p0/m,       z30.d
    ext     z18.b,      z18.b,      z18.b,      #8
    add     z17.d,      z17.d,      z18.d
    cmphi   p1.d,       p0/z,       z18.d,      z17.d
    sub     z31.d,      p1/m,       z31.d,      z22.d
    add     z17.d,      z17.d,      z29.d
    cmphi   p1.d,       p0/z,       z29.d,      z17.d
    sub     z31.d,      p1/m,       z31.d,      z22.d
    add     z17.d,      z17.d,      z30.d
    cmphi   p1.d,       p0/z,       z30.d,      z17.d
    sub     z31.d,      p1/m,       z31.d,      z22.d
    
    //check if > p
    dup     z18.b,      z17.b[63]
    cmphs   p1.b,       p0/z,       z18.b,      #102
    ext     z31.b,      z31.b,      z31.b,      #56
    add     z31.d,      p1/m,       z31.d,      z21.d
    //start carry propagation
    
    add     z2.d,       z17.d,      z31.d
    cmphi   p1.d,       p0/z,       z31.d,      z2.d
    movprfx z21,        z20
    sub     z21.b,      z21.b,      #65
    cnt     z27.d,      p0/m,       z2.d
    sub     z27.b,      p1/m,       z27.b,      z21.b
    tbl     z23.b,      { z27.b },  z28.b
    add     z23.d,      z23.d,      z21.d
    add     z27.b,      z27.b,      z21.b
    tbl     z24.b,      { z23.b },  z26.b
    cmpne   p3.b,       p0/z,       z24.b,      z27.b
    sub     z2.d,       p3/m,       z2.d,       z22.d
    st1d    { z2.d },   p0,         [x2]
    ret

.global fp_correction
fp_correction:
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]

    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
    mov     x1, x19
    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18
    sbc     x19, xzr, xzr

    and     x11, x11, x19
    adds    x3, x3, x11
    and     x12, x12, x19
    adcs    x4, x4, x12
    and     x13, x13, x19
    adcs    x5, x5, x13
    and     x14, x14, x19
    adcs    x6, x6, x14
    and     x15, x15, x19
    adcs    x7, x7, x15
    and     x16, x16, x19
    adcs    x8, x8, x16
    and     x17, x17, x19
    adcs    x9, x9, x17 
    and     x18, x18, x19
    adcs    x10, x10, x18
    mov     x19, x1
    stp     x3, x4, [x0]
    stp     x5, x6, [x0,#16]
    stp     x7, x8, [x0,#32]
    stp     x9, x10, [x0,#48]
    
    ret

.global fp_cswap
fp_cswap:
    ptrue p0.d
    ld1d    z0.d,       p0/z,       [x0]
    ld1d    z1.d,       p0/z,       [x1]
    dup     z2.d,       x2
    cmpne   p1.d,       p0/z,       z2.d,       #0
    st1d    z1.d,       p1,         [x0]
    st1d    z0.d,       p1,         [x1]
    ret

.global fp_cmov
fp_cmov:
    ptrue p0.d
    ld1d    z1.d,       p0/z,       [x1]
    dup     z2.d,       x2
    cmpne   p1.d,       p0/z,       z2.d,       #0
    st1d    z1.d,       p1,         [x0]
    ret
    
.global fp_neg2
fp_neg2:
    ldp     x3, x4,   [x1]
    ldp     x5, x6,   [x1,#16]
    ldp     x7, x8,   [x1,#32]
    ldp     x9, x10,  [x1,#48]

    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
orr     x2, x3, x4
    orr     x2, x2, x5
    orr     x2, x2, x6
    orr     x2, x2, x7
    orr     x2, x2, x8
    orr     x2, x2, x9
    orr     x2, x2, x10
    subs    x3, x11, x3
    sbcs    x4, x12, x4
    sbcs    x5, x13, x5
    sbcs    x6, x14, x6
    sbcs    x7, x15, x7
    sbcs    x8, x16, x8
    sbcs    x9, x17, x9
    sbcs    x10, x18, x10
    csel    x11, x11, xzr, lo
    csel    x12, x12, xzr, lo
    csel    x13, x13, xzr, lo
    csel    x14, x14, xzr, lo
    csel    x15, x15, xzr, lo
    csel    x16, x16, xzr, lo
    csel    x17, x17, xzr, lo
    csel    x18, x18, xzr, lo
    adds    x3, x11, x3
    adcs    x4, x12, x4
    adcs    x5, x13, x5
    adcs    x6, x14, x6
    adcs    x7, x15, x7
    adcs    x8, x16, x8
    adcs    x9, x17, x9
    adc    x10, x18, x10   
    subs    xzr, x2, xzr
    csel    x3,  x3,  xzr, ne
    csel    x4,  x4,  xzr, ne
    csel    x5,  x5,  xzr, ne
    csel    x6,  x6,  xzr, ne
    csel    x7,  x7,  xzr, ne
    csel    x8,  x8,  xzr, ne
    csel    x9,  x9,  xzr, ne
    csel    x10, x10, xzr, ne
    stp     x3, x4, [x0]
    stp     x5, x6, [x0,#16]
    stp     x7, x8, [x0,#32]
    stp     x9, x10, [x0,#48]
    ret
.global uintbig_iszero
uintbig_iszero:
    ptrue p0.d
    ld1d z0.d, p0/z, [x0]
    cmpne   p1.d, p0/z, z0.d, #0
    cset    x0, eq
    ret

.global uintbig_isequal
uintbig_isequal:
    ptrue p0.d
    ld1d z0.d, p0/z, [x0]
    ld1d z1.d, p0/z, [x1]
    cmpne   p1.d, p0/z, z0.d, z1.d
    cset    x0, eq
    ret
.global fp_iszero
fp_iszero:
    ptrue p0.d
    ld1d z0.d, p0/z, [x0]
    ldr  x1, =p511
    ld1d z1.d, p0/z, [x1]
    cmpne   p1.d, p0/z, z0.d, #0
    cset    x0, eq
    cmpne   p1.d, p0/z, z0.d, z1.d
    cset    x1, eq
    orr     x0, x0, x1
    ret
.global fp_double2
fp_double2:
    ldp     x3, x4,   [x1]
    ldp     x5, x6,   [x1,#16]
    ldp     x7, x8,   [x1,#32]
    ldp     x9, x10,  [x1,#48]
    mov     x2, x19
fp_double2_:
    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
    adds    x3, x3, x3
    adcs    x4, x4, x4
    adcs    x5, x5, x5
    adcs    x6, x6, x6
    adcs    x7, x7, x7
    adcs    x8, x8, x8
    adcs    x9, x9, x9
    adcs    x10, x10, x10

    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18
    sbc     x19, xzr, xzr

    and     x11, x11, x19
    adds    x3, x3, x11
    and     x12, x12, x19
    adcs    x4, x4, x12
    and     x13, x13, x19
    adcs    x5, x5, x13
    and     x14, x14, x19
    adcs    x6, x6, x14
    and     x15, x15, x19
    adcs    x7, x7, x15
    and     x16, x16, x19
    adcs    x8, x8, x16
    and     x17, x17, x19
    adcs    x9, x9, x17 
    and     x18, x18, x19
    adcs    x10, x10, x18
    mov     x19, x2
    stp     x3, x4, [x0]
    stp     x5, x6, [x0,#16]
    stp     x7, x8, [x0,#32]
    stp     x9, x10, [x0,#48]
    
    ret
.global fp_quadruple2
fp_quadruple2:
    ldp     x3, x4,   [x1]
    ldp     x5, x6,   [x1,#16]
    ldp     x7, x8,   [x1,#32]
    ldp     x9, x10,  [x1,#48]
    mov     x2, x19
    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
    adds    x3, x3, x3
    adcs    x4, x4, x4
    adcs    x5, x5, x5
    adcs    x6, x6, x6
    adcs    x7, x7, x7
    adcs    x8, x8, x8
    adcs    x9, x9, x9
    adcs    x10, x10, x10

    subs    x3, x3, x11
    sbcs    x4, x4, x12
    sbcs    x5, x5, x13
    sbcs    x6, x6, x14
    sbcs    x7, x7, x15
    sbcs    x8, x8, x16
    sbcs    x9, x9, x17
    sbcs    x10, x10, x18
    sbc     x19, xzr, xzr

    and     x11, x11, x19
    adds    x3, x3, x11
    and     x12, x12, x19
    adcs    x4, x4, x12
    and     x13, x13, x19
    adcs    x5, x5, x13
    and     x14, x14, x19
    adcs    x6, x6, x14
    and     x15, x15, x19
    adcs    x7, x7, x15
    and     x16, x16, x19
    adcs    x8, x8, x16
    and     x17, x17, x19
    adcs    x9, x9, x17 
    and     x18, x18, x19
    adcs    x10, x10, x18
    b       fp_double2_
    