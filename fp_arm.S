
#include "uintbig_namespace.h"
#include "fp_namespace.h"
.align 2
.data
#if defined(__APPLE__)
    #define fmt(f)    _##f
#else
    #define fmt(f)    f
#endif
.global fmt(fp_0)
fmt(fp_0):
    .quad 0,0,0,0,0,0,0,0

.global fmt(fp_1)
fmt(fp_1): /* 2^512 mod p */
    .quad 0xc8fc8df598726f0a, 0x7b1bc81750a6af95, 0x5d319e67c1e961b4, 0xb0aa7275301955f1
    .quad 0x4a080672d9ba6c64, 0x97a5ef8a246ee77b, 0x06ea9e5d4383676a, 0x3496e2e117e0ec80

.global fmt(fp_2)
fmt(fp_2): /* 2^513 mod p */
    .quad 0x767762e5fd1e1599, 0x33c5743a49a0b6f6, 0x68fc0c0364c77443, 0xb9aa1e24f83f56db
    .quad 0x3914101f20520efb, 0x7b1ed6d95b1542b4, 0x114a8be928c8828a, 0x03793732bbb24f40
.global fmt(fp_mulsq_count)
fmt(fp_mulsq_count):
    .quad 0
.global fmt(fp_sq_count)
fmt(fp_sq_count):
    .quad 0
.global fmt(fp_addsub_count)
fmt(fp_addsub_count):
    .quad 0
.global fmt(uintbig_1)
fmt(uintbig_1):
    .quad 1, 0, 0, 0
    .quad 0, 0, 0, 0

.global fmt(uintbig_p)
fmt(uintbig_p):
    .quad 0x1b81b90533c6c87b, 0xc2721bf457aca835, 0x516730cc1f0b4f25, 0xa7aac6c567f35507
    .quad 0x5afbfcc69322c9cd, 0xb42d083aedc88c42, 0xfc8ab0d15e3e4c4a, 0x65b48e8f740f89bf

.global fmt(uintbig_four_sqrt_p)
fmt(uintbig_four_sqrt_p):
    .quad 0x17895e71e1a20b3f, 0x38d0cd95f8636a56, 0x142b9541e59682cd, 0x856f1399d91d6592
    .quad 2, 0, 0, 0

.text
p511:
.quad 0x1b81b90533c6c87b
.quad 0xc2721bf457aca835
.quad 0x516730cc1f0b4f25
.quad 0xa7aac6c567f35507
.quad 0x5afbfcc69322c9cd
.quad 0xb42d083aedc88c42
.quad 0xfc8ab0d15e3e4c4a
.quad 0x65b48e8f740f89bf

minus_p511_inverse:
.quad 0x66c1301f632e294d





.macro stack_pointer_st
    sub   sp,  sp, #80
    stp   x19, x20, [sp]
    stp   x21, x22, [sp, #16]
    stp   x23, x24, [sp, #32]
    stp   x25, x26, [sp, #48]
    stp   x27, x28, [sp, #64]
.endm

.macro stack_pointer_ld
    ldp   x19, x20, [sp]
    ldp   x21, x22, [sp, #16]
    ldp   x23, x24, [sp, #32]
    ldp   x25, x26, [sp, #48]
    ldp   x27, x28, [sp, #64]
    add   sp,  sp,  #80
.endm


.global fmt(fp_add_512)
fmt(fp_add_512):
    //stack_pointer_st

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

    ldr     x11, p511
    ldr     x12, p511 + 8
    ldr     x13, p511 + 16
    ldr     x14, p511 + 24
    ldr     x15, p511 + 32
    ldr     x16, p511 + 40
    ldr     x17, p511 + 48
    ldr     x18, p511 + 56
    mov     x0, x19
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
    adc    x10, x10, x18

    stp     x3, x4, [x2]
    stp     x5, x6, [x2,#16]
    stp     x7, x8, [x2,#32]
    stp     x9, x10, [x2,#48]
    mov     x19, x0
    //stack_pointer_ld
    ret

.global fmt(fp_sub_512)
fmt(fp_sub_512):
    stack_pointer_st

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
    
    stp     x3, x4, [x2]
    stp     x5, x6, [x2,#16]
    stp     x7, x8, [x2,#32]
    stp     x9, x10, [x2,#48]
    
    stack_pointer_ld
    ret
.global fmt(mp_add_512)
fmt(mp_add_512):
    //stack_pointer_st

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
    
    //stack_pointer_ld
    ret
.global fmt(mp_sub_512)
fmt(mp_sub_512):
    //stack_pointer_st

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
    
    //stack_pointer_ld
    ret
.global fmt(mp_mul_u64)

fmt(mp_mul_u64):
    stack_pointer_st

    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
    
    mul     x12, x3, x1
    umulh   x13, x3, x1

    mul     x14, x4, x1
    umulh   x15, x4, x1         

    mul     x16, x5, x1
    umulh   x17, x5, x1         

    mul     x18, x6, x1
    umulh   x19, x6, x1         

    mul     x20, x7, x1
    umulh   x21, x7, x1         

    mul     x22, x8, x1
    umulh   x23, x8, x1         

    mul     x24, x9, x1
    umulh   x25, x9, x1         

    mul     x26, x10, x1
    umulh   x27, x10, x1

    adds    x13, x13, x14
    adcs    x15, x15, x16
    adcs    x17, x17, x18
    adcs    x19, x19, x20
    adcs    x21, x21, x22
    adcs    x23, x23, x24
    adc    x25, x25, x26

    stp     x12, x13, [x2]
    stp     x15, x17, [x2, #16]
    stp     x19, x21, [x2, #32]
    stp     x23, x25, [x2, #48]

    stack_pointer_ld

    ret        
.macro schoolbook_compact_registers_first
    mul     x10, x3, x7
    umulh   x12, x3, x7
    
    mul     x14, x4, x7
    umulh   x16, x4, x7
    
    mul     x18, x5, x7
    umulh   x20, x5, x7

    mul     x22, x6, x7
    umulh   x24, x6, x7

    adds    x12, x12, x14
    adcs    x16, x16, x18
    adcs    x20, x20, x22

    ldp     x3, x4, [x0, #32]
    ldp     x5, x6, [x0, #48]

    mul     x25, x3, x7
    umulh   x26, x3, x7

    mul     x27, x4, x7
    umulh   x14, x4, x7

    mul     x18, x5, x7
    umulh   x22, x5, x7

    mul     x3, x6, x7
    umulh   x4, x6, x7

    adcs    x24, x24, x25
    adcs    x26, x26, x27
    adcs    x14, x14, x18
    adcs    x22, x22, x3
    adc     x4, x4, xzr
.endm

.macro schoolbook_compact_registers_second
    ldr     x3, p511
    ldr     x4, p511 + 8
    ldr     x5, p511 + 16
    ldr     x6, p511 + 24

    mul     x10, x3, x28
    umulh   x12, x3, x28
    
    mul     x14, x4, x28
    umulh   x16, x4, x28
    
    mul     x18, x5, x28
    umulh   x20, x5, x28

    mul     x22, x6, x28
    umulh   x24, x6, x28

    adds    x12, x12, x14
    adcs    x16, x16, x18
    adcs    x20, x20, x22

    ldr     x3, p511 + 32
    ldr     x4, p511 + 40
    ldr     x5, p511 + 48
    ldr     x6, p511 + 56
    
    mul     x25, x3, x28
    umulh   x26, x3, x28

    mul     x27, x4, x28
    umulh   x14, x4, x28

    mul     x18, x5, x28
    umulh   x22, x5, x28 
    
    mul     x3, x6, x28
    umulh   x4, x6, x28 

    adcs    x24, x24, x25
    adcs    x26, x26, x27
    adcs    x14, x14, x18
    adcs    x22, x22, x3
    adc     x4, x4, xzr
.endm
.global fmt(fp_mul_mont_512)
fmt(fp_mul_mont_512):
    stack_pointer_st

    // 0
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1]

    mul     x8, x3, x7
    umulh   x9, x3, x7
    
    mul     x10, x4, x7
    umulh   x11, x4, x7
    
    mul     x12, x5, x7
    umulh   x13, x5, x7

    mul     x14, x6, x7
    umulh   x15, x6, x7

    adds    x9, x9, x10
    adcs    x11, x11, x12
    adcs    x13, x13, x14

    ldp     x3, x4, [x0, #32]
    ldp     x5, x6, [x0, #48]

    mul     x16, x3, x7
    umulh   x17, x3, x7

    mul     x18, x4, x7
    umulh   x19, x4, x7

    mul     x20, x5, x7
    umulh   x21, x5, x7

    mul     x22, x6, x7
    umulh   x23, x6, x7

    adcs    x15, x15, x16
    adcs    x17, x17, x18
    adcs    x19, x19, x20
    adcs    x21, x21, x22
    adc     x23, x23, xzr

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x8

    ldr     x3, p511
    ldr     x4, p511 + 8
    ldr     x5, p511 + 16
    ldr     x6, p511 + 24

    mul     x10, x3, x28
    umulh   x12, x3, x28

    mul     x14, x4, x28
    umulh   x16, x4, x28

    mul     x18, x5, x28
    umulh   x20, x5, x28

    mul     x22, x6, x28
    umulh   x24, x6, x28

    adds    x12, x12, x14
    adcs    x16, x16, x18
    adcs    x20, x20, x22

    ldr     x3, p511 + 32
    ldr     x4, p511 + 40
    ldr     x5, p511 + 48
    ldr     x6, p511 + 56
    
    mul     x25, x3, x28
    umulh   x26, x3, x28

    mul     x27, x4, x28
    umulh   x14, x4, x28

    mul     x18, x5, x28
    umulh   x22, x5, x28 
    
    mul     x3, x6, x28
    umulh   x4, x6, x28 

    adcs    x24, x24, x25
    adcs    x26, x26, x27
    adcs    x14, x14, x18
    adcs    x22, x22, x3
    adc     x4, x4, xzr

    adds    x8, x8, x10
    adcs    x9, x9, x12
    adcs    x11, x11, x16
    adcs    x13, x13, x20
    adcs    x15, x15, x24
    adcs    x17, x17, x26
    adcs    x19, x19, x14
    adcs    x21, x21, x22
    adcs    x23, x23, x4
    adc     x8, xzr, xzr    
    
    // 1
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #8]

    schoolbook_compact_registers_first

    adds    x9, x9, x10
    adcs    x11, x11, x12
    adcs    x13, x13, x16
    adcs    x15, x15, x20
    adcs    x17, x17, x24
    adcs    x19, x19, x26
    adcs    x21, x21, x14
    adcs    x23, x23, x22
    adc     x8, x8, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x9
    
    schoolbook_compact_registers_second

    adds    x9, x9, x10
    adcs    x11, x11, x12
    adcs    x13, x13, x16
    adcs    x15, x15, x20
    adcs    x17, x17, x24
    adcs    x19, x19, x26
    adcs    x21, x21, x14
    adcs    x23, x23, x22
    adcs    x8, x8, x4
    adc     x9, xzr, xzr   
    
    // 2
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #16]

    schoolbook_compact_registers_first

    adds    x11, x11, x10
    adcs    x13, x13, x12
    adcs    x15, x15, x16
    adcs    x17, x17, x20
    adcs    x19, x19, x24
    adcs    x21, x21, x26
    adcs    x23, x23, x14
    adcs    x8, x8, x22
    adc     x9, x9, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x11

    schoolbook_compact_registers_second

    adds    x11, x11, x10
    adcs    x13, x13, x12
    adcs    x15, x15, x16
    adcs    x17, x17, x20
    adcs    x19, x19, x24
    adcs    x21, x21, x26
    adcs    x23, x23, x14
    adcs    x8, x8, x22
    adcs    x9, x9, x4
    adc     x11, xzr, xzr  

    // 3
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #24]

    schoolbook_compact_registers_first

    adds    x13, x13, x10
    adcs    x15, x15, x12
    adcs    x17, x17, x16
    adcs    x19, x19, x20
    adcs    x21, x21, x24
    adcs    x23, x23, x26
    adcs    x8, x8, x14
    adcs    x9, x9, x22
    adc     x11, x11, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x13

    schoolbook_compact_registers_second

    adds    x13, x13, x10
    adcs    x15, x15, x12
    adcs    x17, x17, x16
    adcs    x19, x19, x20
    adcs    x21, x21, x24
    adcs    x23, x23, x26
    adcs    x8, x8, x14
    adcs    x9, x9, x22
    adcs    x11, x11, x4
    adc     x13, xzr, xzr   

    // 4
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #32]

    schoolbook_compact_registers_first

    adds    x15, x15, x10
    adcs    x17, x17, x12
    adcs    x19, x19, x16
    adcs    x21, x21, x20
    adcs    x23, x23, x24
    adcs    x8, x8, x26
    adcs    x9, x9, x14
    adcs    x11, x11, x22
    adc     x13, x13, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x15

    schoolbook_compact_registers_second
  
    adds    x15, x15, x10
    adcs    x17, x17, x12
    adcs    x19, x19, x16
    adcs    x21, x21, x20
    adcs    x23, x23, x24
    adcs    x8, x8, x26
    adcs    x9, x9, x14
    adcs    x11, x11, x22
    adcs    x13, x13, x4
    adc     x15, xzr, xzr   

    // 5
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #40]

    schoolbook_compact_registers_first

    adds    x17, x17, x10
    adcs    x19, x19, x12
    adcs    x21, x21, x16
    adcs    x23, x23, x20
    adcs    x8, x8, x24
    adcs    x9, x9, x26
    adcs    x11, x11, x14
    adcs    x13, x13, x22
    adc     x15, x15, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x17

    schoolbook_compact_registers_second 

    adds    x17, x17, x10
    adcs    x19, x19, x12
    adcs    x21, x21, x16
    adcs    x23, x23, x20
    adcs    x8, x8, x24
    adcs    x9, x9, x26
    adcs    x11, x11, x14
    adcs    x13, x13, x22
    adcs    x15, x15, x4
    adc     x17, xzr, xzr   

    // 6
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #48]

    schoolbook_compact_registers_first

    adds    x19, x19, x10
    adcs    x21, x21, x12
    adcs    x23, x23, x16
    adcs    x8, x8, x20
    adcs    x9, x9, x24
    adcs    x11, x11, x26
    adcs    x13, x13, x14
    adcs    x15, x15, x22
    adc     x17, x17, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x19

    schoolbook_compact_registers_second
  
    adds    x19, x19, x10
    adcs    x21, x21, x12
    adcs    x23, x23, x16
    adcs    x8, x8, x20
    adcs    x9, x9, x24
    adcs    x11, x11, x26
    adcs    x13, x13, x14
    adcs    x15, x15, x22
    adcs    x17, x17, x4
    adc     x19, xzr, xzr   

    // 7
    ldp     x3, x4, [x0]
    ldp     x5, x6, [x0, #16]
    ldr     x7, [x1, #56]

    schoolbook_compact_registers_first

    adds    x21, x21, x10
    adcs    x23, x23, x12
    adcs    x8, x8, x16
    adcs    x9, x9, x20
    adcs    x11, x11, x24
    adcs    x13, x13, x26
    adcs    x15, x15, x14
    adcs    x17, x17, x22
    adc     x19, x19, x4

    ldr     x28, minus_p511_inverse
    mul     x28, x28, x21

    schoolbook_compact_registers_second

    adds    x21, x21, x10
    adcs    x23, x23, x12   // mc0
    adcs    x8, x8, x16     // mc1
    adcs    x9, x9, x20     // mc2
    adcs    x11, x11, x24   // mc3
    adcs    x13, x13, x26   // mc4
    adcs    x15, x15, x14   // mc5
    adcs    x17, x17, x22   // mc6
    adc    x19, x19, x4     // mc7

    ldr     x10, p511
    ldr     x12, p511 + 8
    ldr     x14, p511 + 16
    ldr     x16, p511 + 24

    ldr     x3, p511 + 32
    ldr     x4, p511 + 40
    ldr     x5, p511 + 48
    ldr     x6, p511 + 56
    
    subs    x23, x23, x10
    sbcs    x8, x8, x12
    sbcs    x9, x9, x14
    sbcs    x11, x11, x16
    sbcs    x13, x13, x3
    sbcs    x15, x15, x4
    sbcs    x17, x17, x5
    sbcs    x19, x19, x6
    sbc     x28, xzr, xzr

    and     x10, x10, x28
    and     x12, x12, x28
    and     x14, x14, x28
    and     x16, x16, x28
    and     x3, x3, x28
    and     x4, x4, x28
    and     x5, x5, x28
    and     x6, x6, x28

    adds    x23, x23, x10
    adcs    x8, x8, x12
    adcs    x9, x9, x14
    adcs    x11, x11, x16
    adcs    x13, x13, x3
    adcs    x15, x15, x4
    adcs    x17, x17, x5
    adcs    x19, x19, x6
    
    stp     x23, x8, [x2]
    stp     x9, x11, [x2, #16]
    stp     x13, x15, [x2, #32]
    stp     x17, x19, [x2, #48]

    stack_pointer_ld

    ret
//*/
.global fmt(fp_cswap)
fmt(fp_cswap):
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
     
    ldp     x11, x12, [x1]
    ldp     x13, x14, [x1,#16]
    ldp     x15, x16, [x1,#32]
    ldp     x17, x18, [x1,#48]

    cmp     x2,  xzr
    csel    x2,  x3, x11,  eq
    csel    x11, x11, x3,  eq
    csel    x3,  x4, x12,  eq
    csel    x12, x12, x4,  eq
    csel    x4,  x5, x13,  eq
    csel    x13, x13, x5,  eq
    csel    x5,  x6, x14,  eq
    csel    x14, x14, x6,  eq
    csel    x6,  x7, x15,  eq
    csel    x15, x15, x7,  eq
    csel    x7,  x8, x16,  eq
    csel    x16, x16, x8,  eq
    csel    x8,  x9, x17,  eq
    csel    x17, x17, x9,  eq
    csel    x9,  x10, x18, eq
    csel    x18, x18, x10, eq

    stp     x2, x3, [x0, #0]
    stp     x4, x5, [x0, #16]
    stp     x6, x7, [x0, #32]
    stp     x8, x9, [x0, #48]

    stp     x11, x12, [x1, #0]
    stp     x13, x14, [x1, #16]
    stp     x15, x16, [x1, #32]
    stp     x17, x18, [x1, #48]
    ret

.global fmt(fp_cmov)
fmt(fp_cmov):
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
     
    ldp     x11, x12, [x1]
    ldp     x13, x14, [x1,#16]
    ldp     x15, x16, [x1,#32]
    ldp     x17, x18, [x1,#48]

    cmp     x2,  xzr
    csel    x2,  x3, x11,  eq
    csel    x3,  x4, x12,  eq
    csel    x4,  x5, x13,  eq
    csel    x5,  x6, x14,  eq
    csel    x6,  x7, x15,  eq
    csel    x7,  x8, x16,  eq
    csel    x8,  x9, x17,  eq
    csel    x9,  x10, x18, eq

    stp     x2, x3, [x0, #0]
    stp     x4, x5, [x0, #16]
    stp     x6, x7, [x0, #32]
    stp     x8, x9, [x0, #48]

    ret

.global fmt(fp_correction)
.global fmt(initPredicate)
fmt(fp_correction):
fmt(initPredicate):
    ret

.global fmt(fp_neg2)
fmt(fp_neg2):
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
    sbc    x10, x18, x10
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

.global fmt(uintbig_iszero)
.global fmt(fp_iszero)
fmt(fp_iszero):
fmt(uintbig_iszero):
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
uintbig_iszero_:
    orr     x0, x3, x4
    orr     x2, x5, x6
    orr     x0, x0, x2
    orr     x4, x7, x8
    orr     x6, x9, x10
    orr     x4, x4, x6
    orr     x0, x0, x4
    subs    xzr, x0, xzr
    cset    x0, eq
    ret

.global fmt(uintbig_isequal)

fmt(uintbig_isequal):
    ldp     x3, x4,   [x0]
    ldp     x5, x6,   [x0,#16]
    ldp     x7, x8,   [x0,#32]
    ldp     x9, x10,  [x0,#48]
    ldp     x11, x12, [x1]
    ldp     x13, x14, [x1,#16]
    ldp     x15, x16, [x1,#32]
    ldp     x17, x18, [x1,#48]
    eor     x3, x3, x11
    eor     x4, x4, x12
    eor     x5, x5, x13
    eor     x6, x6, x14
    eor     x7, x7, x15
    eor     x8, x8, x16
    eor     x9, x9, x17
    eor     x10, x10, x18
    b uintbig_iszero_
.global fmt(fp_double2)
fmt(fp_double2):
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
.global fmt(fp_quadruple2)
fmt(fp_quadruple2):
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
    
