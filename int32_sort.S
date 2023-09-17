#if defined(__APPLE__)
    #define fmt(f)    _##f
#else
    #define fmt(f)    f
#endif
.p2align 2
.global fmt(crypto_sort_int32)
fmt(crypto_sort_int32):
    mov     x2, xzr
LOOP1_TEST:
    cmp     x2, x1
    bge     LOOP1_END
    add     x3, x2, #1
    ldr     w4, [x0, x2, lsl #2]
LOOP2_TEST:
    cmp     x3, x1
    bge     LOOP2_END
    ldr     w5, [x0, x3, lsl #2]
    cmp     w4, w5
    csel    w6, w5, w4, lt
    csel    w4, w4, w5, lt
    str     w6, [x0, x3, lsl #2]
    add     x3, x3, #1
    b       LOOP2_TEST
LOOP2_END:
    
    str     w4, [x0, x2, lsl #2]
    add     x2, x2, #1
    b       LOOP1_TEST
LOOP1_END:
    ret