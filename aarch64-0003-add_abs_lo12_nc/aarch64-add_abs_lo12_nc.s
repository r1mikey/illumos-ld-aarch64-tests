# REQUIRES: aarch64
# RUN: llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd %s -o %t
# RUN: echo '.globl zero; zero = 0' | llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd -o %t2.o
# RUN: not ld.lld %t %t2.o -o /dev/null 2>&1 | FileCheck %s

.globl _start
_start:
  add x0, x0, :lo12:.L.str
.L.str:
  .asciz "blah"
  .size mystr, 4
