// REQUIRES: aarch64
// RUN: llvm-mc -filetype=obj -triple=aarch64 %s -o %t.o
// RUN: llvm-mc -filetype=obj -triple=aarch64 %S/Inputs/abs256.s -o %t256.o
// RUN: ld.lld %t.o %t256.o -o %t
// RUN: llvm-objdump -s %t | FileCheck %s --check-prefixes=CHECK,LE

.globl _start
_start:
.data
  .xword foo + 0x24

// S = 0x100, A = 0x24
// S + A = 0x124
// CHECK: Contents of section .R_AARCH64_ABS64:
// LE-NEXT: 210120 24010000 00000000
