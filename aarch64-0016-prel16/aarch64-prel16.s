# REQUIRES: aarch64
# RUN: llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd %s -o %t
# RUN: echo '.globl zero; zero = 0' | llvm-mc -filetype=obj -triple=aarch64-unknown-freebsd -o %t2.o
# RUN: not ld.lld %t %t2.o -o /dev/null 2>&1 | FileCheck %s

#
# In the first case:
#  S = 0x100 (256)
#  A = 0x2205bf (2229695)
#  P = 0x2106c0 (2164416)
# S + A - P => 256 + 2229695 - 2164416 = 65535 (0xffff)
#
# In the second case:
#  S = 0x100 (256)
#  A = 0x2085c2 (2131394)
#  P = 0x2106c2 (2164418)
# S + A - P -> 256 + 2131394 - 2164418 = -32768 (0x8000)
#

.globl _start
_start:
.data
  .hword foo - . + 0x2205bf
  .hword foo - . + 0x2085c2

