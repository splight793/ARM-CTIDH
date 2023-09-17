#ifndef uintbig_h
#define uintbig_h

#include "uintbig_namespace.h"

#include <stdbool.h>
#include <stdint.h>

#define UINTBIG_LIMBS ((BITS+63)/64)

typedef struct uintbig {
    uint64_t c[UINTBIG_LIMBS];
} uintbig;

extern const uintbig uintbig_p;
extern const uintbig uintbig_1;
extern const uintbig uintbig_four_sqrt_p;

static inline void uintbig_set(uintbig *x, uint64_t y){
    x->c[0] = y;
    for(int i = 1; i < 8; i++)
        x->c[i] = 0;
}

static inline long long uintbig_bit(uintbig const *x, uint64_t k){
    return (x->c[k / 64] >> (k & 63)) & 1;
}
long long mp_add_512(const uint64_t *a, const uint64_t *b, uint64_t *c);
long long mp_sub_512(const uint64_t *a, const uint64_t *b, uint64_t *c);
void mp_mul_u64(const uint64_t *a, const uint64_t b, uint64_t *c);
static inline long long uintbig_add3(uintbig *x, uintbig const *y, uintbig const *z){
    return mp_add_512(y->c,z->c,x->c);
} /* returns carry */
static inline long long uintbig_sub3(uintbig *x, uintbig const *y, uintbig const *z){
    return mp_sub_512(y->c,z->c,x->c);
} /* returns borrow */

static inline void uintbig_mul3_64(uintbig *x, uintbig const *y, uint64_t z){
    mp_mul_u64(y->c,z, x->c);
}

static inline long long uintbig_bits_vartime(const uintbig *x)
{
  long long result = BITS;
  while (result > 0 && !uintbig_bit(x,result-1)) --result;
  return result;
}

static inline long long uintbig_uint64_iszero(uint64_t t)
{
  // is t nonzero?
  t |= t>>32;
  // are bottom 32 bits of t nonzero?
  t &= 0xffffffff;
  // is t nonzero? between 0 and 0xffffffff
  t = -t;
  // is t nonzero? 0, or between 2^64-0xffffffff and 2^64-1
  t >>= 63;
  return 1-(long long) t;
}

long long uintbig_iszero(const uintbig *x);/*/
{
  uint64_t t = 0;
  for (long long i = 0;i < UINTBIG_LIMBS;++i)
    t |= x->c[i];
  return uintbig_uint64_iszero(t);
}//*/

long long uintbig_isequal(const uintbig *x,const uintbig *y);/*
{
  uint64_t t = 0;
  for (long long i = 0;i < UINTBIG_LIMBS;++i)
    t |= (x->c[i])^(y->c[i]);
  return uintbig_uint64_iszero(t);
}*/

#endif
