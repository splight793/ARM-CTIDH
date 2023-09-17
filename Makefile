ifndef $(CC)
CC=clang

endif
DEF=-D'NAMESPACEBITS(x)=highctidh_511_\#\#x' -D'NAMESPACEGENERIC(x)=highctidh_\#\#x' -DBITS=511 -D'_NAMESPACEBITS(x)=_highctidh_511_\#\#x'
#$(CC) -Wl,--start-group test_a64.o fp.o fp_arm.o libhighctidh_511.a -lc -Wl,--end-group -o ctidh_a64

ifeq ($(ARCH), SVE)
ARCH_OPTION=mcpu=a64fx+sve
ARITH_SRC= fp_sve.S int32_sort.S
ARITH_OBJ = fp_sve.o int32_sort.o
else  ifeq ($(ARCH), ARM64)
ARCH_OPTION= -march=armv8-a
ARITH_SRC = fp_arm.S fp.c int32_sort.S
ARITH_OBJ = fp_arm.o fp.o int32_sort.o
endif

COMON_SRC=	crypto_classify.c csidh.c fp_inv511.c mont.c primes511.c\
		 	randombytes.c steps.c crypto_declassify.c elligator.c\
			fp_sqrt511.c poly.c random.c skgen.c steps_untuned.c validate.c

SRCS=$(COMON_SRC) $(ARITH_SRC)
OBJS=$(COMON_SRC:.c=.o) $(ARITH_OBJ)

OPTION= -Wno-discarded-qualifiers -fwrapv $(ARCH_OPTION)

ifeq ($(BENCH), CYCLES)
BENCHINCYCLE= -D_BENCH_IN_CYCLE_COUNT_
endif

.PHONY: all
all:
ifndef ARCH	
	@echo Usage: make CC=[gcc/clang] ARCH=[ARM64/SVE] BENCH=[NS/CYCLES]
	@echo Please specify the measurement of benchmarks to complile the benchmark program
else
	$(CC) -c -O3 $(OPTION)  $(DEF) $(SRCS)
	ar rc libhighctidh_511.a $(OBJS)
	ranlib libhighctidh_511.a
ifdef BENCH
	$(CC) -c -O0 $(OPTION) $(ARCH_OPTION) $(DEF) $(BENCHINCYCLE) test.c
	$(CC) -O3 test.o libhighctidh_511.a -o ctidh_test
endif
endif

.PHONY: clean
clean:
	rm -f libhighctidh_511.a ctidh_test $(COMON_SRC:.c=.o) fp_sve.o fp_arm.o fp.o int32_sort.o test.o 
