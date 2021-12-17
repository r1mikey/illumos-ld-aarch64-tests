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
  .word foo@PLT - . + 2164031
  .word foo@PLT - . - 2145319484
  .word foo@PLT - .

# 0xffffff7f - (0x100 - 2164416)
# 4328328
# 2149647812
# X = 0x80000000
# S = 0x100
# A = 0
# P = 0x2106c4
# 4292861856 - (0x100 - 2106c0)
# /// 202158: S = 0x100, A = 0x80202057, P = 0x202158
# ///         S + A - P = 0xffffff7f
