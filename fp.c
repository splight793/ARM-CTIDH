//AARCH64 workaround
#include "fp.h"
void fp_add_512(const uint64_t *a, const uint64_t *b, uint64_t *c);
void fp_sub_512(const uint64_t *a, const uint64_t *b, uint64_t *c);
void fp_mul_mont_512(const uint64_t *a, const uint64_t *b, uint64_t *c);
void fp_add3(fp *x, fp const *y, fp const *z) 
{fp_add_512(y->x.c, z->x.c,x->x.c);}
void fp_sub3(fp *x, fp const *y, fp const *z)
{ fp_sub_512(y->x.c, z->x.c,x->x.c);}
void fp_mul3(fp *x, fp const *y, fp const *z)
{fp_mul_mont_512(y->x.c, z->x.c,x->x.c); }