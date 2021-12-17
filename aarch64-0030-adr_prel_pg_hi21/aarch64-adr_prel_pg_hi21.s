
.global _start
_start:
  adrp x1,mystr
.data
mystr:
  .asciz "blah"
  .size mystr, 4
