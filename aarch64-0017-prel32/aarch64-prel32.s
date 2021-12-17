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
.data
  .word foo - . + 0x1002105bf
  .word foo - . - 0x7fdefa3c
