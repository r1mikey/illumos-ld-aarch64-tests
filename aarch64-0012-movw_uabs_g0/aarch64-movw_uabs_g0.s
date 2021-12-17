# REQUIRES: aarch64
# RUN: llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd %s -o %t
# RUN: echo '.globl zero; zero = 0' | llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd -o %t2.o
# RUN: not ld.lld %t %t2.o -o /dev/null 2>&1 | FileCheck %s

# CHECK: relocation R_AARCH64_MOVW_UABS_G0 out of range: 65536 is not in [0, 65535]
.globl _start
_start:
  movn x0, #:abs_g0:zero+0xffff
