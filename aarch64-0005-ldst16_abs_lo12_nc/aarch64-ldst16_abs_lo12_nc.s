# REQUIRES: aarch64
# RUN: llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd %s -o %t
# RUN: echo '.globl zero; zero = 0' | llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd -o %t2.o
# RUN: not ld.lld %t %t2.o -o /dev/null 2>&1 | FileCheck %s

.globl _start
_start:
  ldr h17, [x19, :lo12:foo16]
  ldrh w1, [x19, :lo12:foo16]
  ldrh w2, [x19, :lo12:foo16 + 2]
foo16:
  .asciz "foo"
  .size mystr, 4
