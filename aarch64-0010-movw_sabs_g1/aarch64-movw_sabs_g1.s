# REQUIRES: aarch64
# RUN: llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd %s -o %t
# RUN: echo '.globl zero; zero = 0' | llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd -o %t2.o
# RUN: not ld.lld %t %t2.o -o /dev/null 2>&1 | FileCheck %s

.globl _start
_start:
  movn x0, #:abs_g1_s:zero+0xffffffff

# CHECK: relocation R_AARCH64_MOVW_SABS_G2 out of range: 281474976710656 is not in [-281474976710656, 281474976710655]
# movn x0, #:abs_g2_s:zero+0xffffffffffff
