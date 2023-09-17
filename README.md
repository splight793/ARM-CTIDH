# ARMv8-CTIDH v1.0

This repository provides an ARMv8 implementation of 511-bit [CTIDH](https://ctidh.isogeny.org/).

512-bit SVE is supported in this implementation. you can find more information [here](https://arxiv.org/abs/2308.16432).

# How to compile

```bash
$ make CC=[gcc/clang] ARCH=[ARM64/SVE] BENCH=[NS/CYCLES]
```

SVE is supported for gcc > 10 or clang > 9.

The SVE implementation assumed that the hardware has a 512-bit SVE. It can only be executed on A64FX or emulators with correct settings.

The ARM64 implementation has been tested on Linux and MacOS. Thanks [Jalali et. al.](https://github.com/amirjalali65/ARMv8-CSIDH) for their 511-bit prime field arithmetics.

You can omit the `BENCH` option if you do not need the benchmark program. 

To test and benchmark the performance of this library, run
```bash
$ ./ctidh_test
```

You can link the `libhighctidh_511.a` file to your program after compilation.

# License

This repository is  is licensed under the MIT License.
