#
# If this test fails it might be due to the section layout changing, in which
# case you can work out the appropriate addend to produce the required value
# and update the test.
#
# The calculation used here is:
#  X = S + A - P
# Since we know what X we want and we know what S and P are, we can work out
# the new A as follows:
#  X - (S - P) = A
#

.globl _start
_start:
  ldr x8, patatino
  .data
patatino:

// S + A - P = 0x100 + 0x5bc - 0x2106c0 = 0xffffffffffdefffc
// CHECK: Contents of section .R_AARCH64_PREL64:
// LE-NEXT: 2106c0 fcffdeff ffffffff
// BE-NEXT: 2106c0 ffffffff ffdefffc
